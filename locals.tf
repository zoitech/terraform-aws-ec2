locals {
  create_iam_instance_profile =  var.iam_instance_profile_name == "" ? 0 : 1
  iam_instance_profile        = var.iam_instance_profile_name == "" ? "" : aws_iam_instance_profile[0].profile.name
}