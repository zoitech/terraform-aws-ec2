# ec2 instance
variable "ami" {
  description = "The AMI to use for the instance"
  default     = ""
}

variable "instance_type" {
  description = "Specify which instance type to use"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Specify key pair to use for decrypting the login password"
  default     = ""
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  default     = []
}

variable "user_data" {
  type        = string
  description = "(Optional) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  default     = ""
}

# https://github.com/hashicorp/terraform/issues/24188
# lifecycle: Support for dynamic blocks and meta-arguments still open
// variable "lifecycle_ignore_changes" {
//   default = true
// }

# root volume
variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type    = list(any)
  default = null
}

# additional attachment volumes
variable "ebs_volume_data_disks" {
  description = "Additional EBS block devices to attach to the instance"
  type    = map(any)
  default = null

}

# tags
variable "tags_instance" {
  description = "Tags for the instance/server"
  type        = map(any)
  default     = {}
}

variable "tags_root_volume" {
  description = "Tags for the root volume"
  type        = map(any)
  default     = {}
}

variable "tags_ebs_volume_data_disks" {
  description = "Set of tags for all EBS data volumes"
  type        = map(any)
  default     = {}
}
