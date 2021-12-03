# tf_lambda_test

This is a PoC of a lambda function that can be called to receive an attribute of a resource. It works by reading the
Terraform state file inside a S3 bucket (check the permissions on the bucket). 

## How to use the lambda function

This is the example call on how to get the `dns_name` for an AWS LoadBalancer.

```json
{
  "BUCKET": "BUCKET_NAME",
  "KEY": "STATE_FILE",
  "TYPE": "aws_lb",
  "ATTRIBUTE": "dns_name",
  "NAME": "RESOURCE_NAME"
}
```

The example function call will then return the `dns_name` as a string. 
The output would look like this: `"internal-RESOURCE_NAME-ACCOUNT_NUMBER.REGION.elb.amazonaws.com"`.

___

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./lambda-attribute | n/a |
| <a name="module_loadbalancer"></a> [loadbalancer](#module\_loadbalancer) | ./loadbalancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | `"terraform"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name. | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region. | `any` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage name (e.g. dev, staging, prod). | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->