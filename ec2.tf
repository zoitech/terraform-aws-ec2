resource "aws_instance" "instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data              = var.user_data
  iam_instance_profile   = local.iam_instance_profile

  # Modifying any of the root_block_device settings other than volume_size requires resource replacement
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
    }
  }

  tags        = var.tags_instance
  volume_tags = var.tags_root_volume

  # https://github.com/hashicorp/terraform/issues/3116
  # Cannot use interpolations in lifecycle attributes (cannot use variables in lifecycle block)
  # https://github.com/hashicorp/terraform/issues/24188
  # lifecycle: Support for dynamic blocks and meta-arguments still open
  // dynamic "lifecycle" {
  //   for_each = var.lifecycle_ignore_changes == true ? [1] : []
  //   content {
  //     ignore_changes = [
  //       ami
  //     ]
  //   }
  // }

  lifecycle {
    #prevent_destroy = true
    create_before_destroy = true
    ignore_changes = [
      ami
    ]
  }
}
