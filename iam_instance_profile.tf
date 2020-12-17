resource "aws_iam_instance_profile" "profile" {
  count = local.create_iam_instance_profile
  name  = var.iam_instance_profile_name
  role  = var.iam_role_name
}