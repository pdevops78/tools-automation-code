// create a prometheus role
resource "aws_iam_role" "test_role" {
  name = "test_role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}