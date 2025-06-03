// create a prometheus role
resource "aws_iam_role" "test_role" {
  name = "prometheus-role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
//  inline_policy {
//    name = "my_inline_policy"
//
//    policy = jsonencode({
//      Version = "2012-10-17"
//      Statement = [
//        {
//          Action   = ["ec2:Describe*"]
//          Effect   = "Allow"
//          Resource = "*"
//        },
//      ]
//    })
//  }

}
// create an instance profile
resource "aws_iam_instance_profile" "test_profile" {
  name = "prometheus-profile"
  role = aws_iam_role.test_role.name
}
// create an inline policy
resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy-inline"
  role = aws_iam_role.test_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
// actions
data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}
// attach aws policy document
resource "aws_iam_policy" "policy" {
  name        = "test-policy..."
  description = "A test policy"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  policy_arn = aws_iam_policy.policy.id
  role = aws_iam_role.test_role.id
}