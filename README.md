# Production Log Magement: EFK stack


## Tech stack:
1. Cloud - AWS, terrafrom/terragrunt
2. Configuration: Ansible
3. Software: Elasticsearch, FluentD, Fluent Bit, Kibana

## How to deploy / undeploy
1. terragrunt apply -auto-approve  --terragrunt-working-dir ./terra
2. ansible-playbook -i ansible/dynamic_inventory.py ansible/playbook.yml
3. Enjoy, 
4. terragrunt destroy -auto-approve --terragrunt-working-dir ./terra



sudo yum install https://s3.amazonaws.com/packages.treasuredata.com/lts/5/amazon/2023/x86_64/fluent-package-5.0.4-1.amzn2023.x86_64.rpm