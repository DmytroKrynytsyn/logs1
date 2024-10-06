#!/usr/bin/env python
import json
import boto3

def get_ec2_by_tag(tag_key, tag_value):
    ec2_client = boto3.client('ec2')

    response = ec2_client.describe_instances(
        Filters=[
            { 'Name': 'instance-state-name', 'Values': ['running'] },
            { 'Name': f'tag:{tag_key}', 'Values': [tag_value] }
        ]
    )

    instances = []
    reservations = response['Reservations']
    for reservation in reservations:
        instances.extend(reservation['Instances'])

    return instances


def get_public_ip_by_role(role: str) -> str:
    return get_ec2_by_tag("Role", role)[0]['PublicIpAddress']

def get_private_ip_by_role(role: str) -> str:
    return get_ec2_by_tag("Role", role)[0]['PrivateIpAddress']


def main():

    inventory = {
        'elasticsearch': {
            'hosts': [get_public_ip_by_role('elasticsearch')], 
            'vars': { 'ansible_user': 'ec2-user','ansible_ssh_private_key_file': './cks.pem', 'ansible_ssh_common_args': '-o StrictHostKeyChecking=no'}
        },
        'fluentd': {
            'hosts': [get_public_ip_by_role('fluentd')],  
            'vars': { 'ansible_user': 'ec2-user','ansible_ssh_private_key_file': './cks.pem', 'ansible_ssh_common_args': '-o StrictHostKeyChecking=no', 
                      'elasticsearch_ip': get_private_ip_by_role('elasticsearch')}
        },
        'node': {
            'hosts': [get_public_ip_by_role('node')], 
            'vars': { 'ansible_user': 'ec2-user','ansible_ssh_private_key_file': './cks.pem', 'ansible_ssh_common_args': '-o StrictHostKeyChecking=no', 
                      'fluentd_ip': get_private_ip_by_role('fluentd')}
        },
        'kibana': {
            'hosts': [get_public_ip_by_role('kibana')], 
            'vars': { 'ansible_user': 'ec2-user','ansible_ssh_private_key_file': './cks.pem', 'ansible_ssh_common_args': '-o StrictHostKeyChecking=no', 
                      'elasticsearch_ip': get_private_ip_by_role('elasticsearch')}
        }
    }

    print(json.dumps(inventory, indent=2))

if __name__ == '__main__':
    main()
