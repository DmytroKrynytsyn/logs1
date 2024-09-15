
output "elasticsearch_instance_public_ip" {
  description = "Elasticsearch public IP"
  value       = aws_instance.elasticsearch.public_ip
}

output "fluentd_instance_public_ip" {
  description = "Fluentd public IP"
  value       = aws_instance.fluentd.public_ip
}

output "kibana_instance_public_ip" {
  description = "Kibana public IP"
  value       = aws_instance.kibana.public_ip
}

output "node_instance_public_ip" {
  description = "Node public IP"
  value       = aws_instance.node.public_ip
}


output "elasticsearch_instance_private_ip" {
  description = "Elasticsearch private IP"
  value       = aws_instance.elasticsearch.private_ip
}

output "fluentd_instance_private_ip" {
  description = "Fluentd private IP"
  value       = aws_instance.fluentd.private_ip
}

output "kibana_instance_private_ip" {
  description = "Kibana private IP"
  value       = aws_instance.kibana.private_ip
}

output "node_instance_private_ip" {
  description = "Node private IP"
  value       = aws_instance.node.private_ip
}