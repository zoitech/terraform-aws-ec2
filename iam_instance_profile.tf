resource "aws_iam_instance_profile" "profile" {
  name = var.iam_instance_profile_name
  role = var.iam_role_name
}