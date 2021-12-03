# terraform-aws-ec2

Terrafor module for creating EC2 instances.

# Description

This module creates the following resources:

* EC2 instance
* EBS volumes

## Usage Example

```hcl
module "my_ec2" {
  providers = {
    aws = aws
  }
  source                 = "git::https://github.com/zoitech/terraform-aws-ec2.git"
  ami                    = "ami-123456789abcd"
  instance_type          = "t2.micro"
  key_name               = "mykey"
  subnet_id              = "subnet-12345678912345678"
  vpc_security_group_ids = ["sg-12345678912345678"]

  root_block_device = [{
    volume_type           = "gp2"
    volume_size           = "100"
    encrypted             = true
    kms_key_id            = "arn:aws:kms:eu-central-1:123456789123:key/abcdefgh-abcd-abcd-bcd-123456789123"
    delete_on_termination = true
  }]

  ebs_volume_data_disks = {
    "/dev/sdf" = {
       size = 60
       type = "gp2"
     },
     "/dev/sdg" = {
       size = 80
       type = "gp2"
     },
     "/dev/sdh" = {
       size = 100
       type = "gp2"
     }
   }

  tags_instance = {
    Name = "myinstance"
  }

  tags_root_volume = {
    Name = "myinstance-root"
  }

  tags_ebs_volume_data_disks = {
    Name = "myinstance-data"
  }
```

### Referencing a Version Tag

Please refer to [CHANGELOG.md](CHANGELOG.md) for the latest release.

```hcl
module "my_ec2" {
  source = "git::https://github.com/zoitech/terraform-aws-ec2.git?ref=1.0.0"
}
```## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.data_disks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_iam_instance_profile.profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_volume_attachment.data_disks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI to use for the instance | `string` | `""` | no |
| <a name="input_ebs_volume_data_disks"></a> [ebs\_volume\_data\_disks](#input\_ebs\_volume\_data\_disks) | Additional EBS block devices to attach to the instance | `map(any)` | `null` | no |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | (Optional, Forces new resource) The profile's name. If omitted, Terraform will assign a random, unique name. | `string` | `""` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | (Optional) The role name to include in the profile | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Specify which instance type to use | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Specify key pair to use for decrypting the login password | `string` | `""` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Customize details about the root block device of the instance. See Block Devices below for details | `list(any)` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The VPC Subnet ID to launch in | `string` | `""` | no |
| <a name="input_tags_ebs_volume_data_disks"></a> [tags\_ebs\_volume\_data\_disks](#input\_tags\_ebs\_volume\_data\_disks) | Set of tags for all EBS data volumes | `map(any)` | `{}` | no |
| <a name="input_tags_instance"></a> [tags\_instance](#input\_tags\_instance) | Tags for the instance/server | `map(any)` | `{}` | no |
| <a name="input_tags_root_volume"></a> [tags\_root\_volume](#input\_tags\_root\_volume) | Tags for the root volume | `map(any)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | (Optional) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `""` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of security group IDs to associate with | `list` | `[]` | no |

## Outputs

No outputs.
