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
```hcl