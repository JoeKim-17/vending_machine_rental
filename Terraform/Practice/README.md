# How to run

## Setting up the Credentials
- `aws configure`
- `AKIAVUJWQDTHP7KCQD76`
- `rZWwu0UcmH2sWbaS6xh4yApBMhxPhSR5FL7Nfg1q`
- `eu-west-1`
- Enter
---
- They are going to ask you for the:
    - Access key ID
    - Secret access key
    - Default Region
    - Output format
- So thats what you enter

## Set password
- Its going to ask for a password, so just do it early.  
- `export TF_VAR_db_password="hashicorp"`
- This is a bash command
- The password can be anything really

## Initialise Terraform
- `terraform init"`
- This is rather fast, under 5 seconds really.

## Create the instance
- `terraform apply"`
- This took me about 20 minutes on the first run, so be patient
- It will output:
    - rds_hostname = "education.csxil53pu1c8.eu-west-1.rds.amazonaws.com"
    - rds_port = 1433
    - rds_username = "edu"
- I will try to change from edu a bit later, but for now, thats that.

## Cleaning up the instance.
- Run command
- `terraform destroy`
- `hashicorp`
