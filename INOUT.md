# Terraform inputs and outputs.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias\_by\_name | n/a | `bool` | `true` | no |
| alias\_list | n/a | `list(string)` | `[]` | no |
| balancer\_egress\_cidr | n/a | `list` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| balancer\_ingress\_cidr | n/a | `list` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| name | n/a | `string` | `"workload"` | no |
| security\_groups | Additional security groups for the balancer | `list` | `[]` | no |
| subnets | Subnets to deploy the balancer. Any change here may cause redeployment | `list` | n/a | yes |
| tags | Additional tags. E.g. environment, backup tags etc | `map` | `{}` | no |
| zone\_id | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| balancer\_sg | ALB security group |
| certificate\_arn | Load balancer certificate arn |
| http\_alt\_listener\_arn | HTTP alt listener arn |
| http\_listener\_arn | HTTP listener arn |
| https\_alt\_listener\_arn | HTTP alt listener arn |
| https\_listener\_arn | HTTP listener arn |

