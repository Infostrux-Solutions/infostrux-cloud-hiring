# Infostrux Cloud Hiring

A repository meant to be used during hiring process for Cloud/Platform Engineers for Infostrux. 

## Getting Started

### Lambda

A Python Lambda Function that downloads from an API and stores a file in S3.

In order to deploy this Lambda Function you will need to [create](https://docs.aws.amazon.com/lambda/latest/dg/python-package.html) a .zip file archive and place it in a folder under `terraform/builds`, this way Terraform will deploy Lambda with the correct Python files. 

### Terraform

#### Setup
Feel free to modify how the Terraform project does Authentication to AWS. Currently it's setup to use an assume role for both backend and provider authentication. 

Using assume roles:
```bash
mkdir terraform/sandbox
cd sandbox
touch sandbox.tfbackend
touch sandbox.tfvars
```

Sample `<env>.tfbackend`
```
role_arn = "arn:aws:iam::<account_number>:role/<role_name>"
bucket="name_of_bucket_for_tf_state"
```

Sample `<env>.tfvars`
```
aws_assume_role = "arn:aws:iam::<account_number>:role/<role_name>"
```

#### Create Workspace:
```bash
terraform workspace new sandbox
```

#### Running Terraform Apply and Plan:

```bash
terraform init -backend-config="sandbox/sandbox.tfbackend"
terraform workspace select sandbox
terraform fmt .
terraform validate
terraform plan -var-file=sandbox/sandbox.tfvars
terraform apply -var-file=sandbox/sandbox.tfvars
```

#### Generate Terraform Docs

Use [Terraform-Docs](https://github.com/terraform-docs/terraform-docs) to generate and inject Terraform resource documentation to this README.

```bash
cd terraform
terraform-docs markdown table --output-file README.md --output-mode inject .
```
