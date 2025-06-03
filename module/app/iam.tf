// create a prometheus role
resource "aws_iam_role" "test_role" {
  name = "prometheus-role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}
// create an instance profile
resource "aws_iam_instance_profile" "test_profile" {
  name = "prometheus-profile"
  role = aws_iam_role.test_role.name
}