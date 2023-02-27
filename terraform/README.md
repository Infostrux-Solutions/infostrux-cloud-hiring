<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.46.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | > 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.46.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ingest_s3"></a> [ingest\_s3](#module\_ingest\_s3) | terraform-aws-modules/s3-bucket/aws | 3.7.0 |
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | 4.10.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cron_trigger](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda_event](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_permission.allow_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_policy.ingest_s3_bucket_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/resources/s3_bucket_policy) | resource |
| [random_string.random_str_5](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_iam_policy_document.ingest_s3_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/4.46.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_assume_role"></a> [aws\_assume\_role](#input\_aws\_assume\_role) | The ARN of the AWS role used to authenticate an AWS Account. | `string` | n/a | yes |
| <a name="input_code_repo"></a> [code\_repo](#input\_code\_repo) | The name of the Github repo where the infrastructure is managed. | `string` | `"infostrux-cloud-hiring"` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | n/a | `string` | `"infostrux"` | no |
| <a name="input_team"></a> [team](#input\_team) | n/a | `string` | `"cloud-chapter"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->