resource "aws_ebs_volume" "data_disks" {
  for_each          = var.ebs_volume_data_disks
  availability_zone = aws_instance.instance.availability_zone
  size              = lookup(var.ebs_volume_data_disks[each.key], "size", null)
  type              = lookup(var.ebs_volume_data_disks[each.key], "type", null)
  encrypted         = lookup(var.ebs_volume_data_disks[each.key], "encrypted", null)
  kms_key_id        = lookup(var.ebs_volume_data_disks[each.key], "kms_key_id", null)
  iops              = lookup(var.ebs_volume_data_disks[each.key], "iops", null)
  tags              = lookup(var.ebs_volume_data_disks[each.key], "tags", var.tags_ebs_volume_data_disks)
}

resource "aws_volume_attachment" "data_disks" {
  for_each    = var.ebs_volume_data_disks
  device_name = each.key
  volume_id   = aws_ebs_volume.data_disks[each.key].id
  instance_id = aws_instance.instance.id
}
