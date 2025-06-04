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
// create an inline policy, for this there is no profile arn
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
// actions for specific prometheus role
data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}
// attach aws policy document this will return profile arn
resource "aws_iam_policy" "policy" {
  name        = "test-policy..."
  description = "A test policy"
  policy      = data.aws_iam_policy_document.policy.json
}
// this policy is associate with policy_Arn and role
resource "aws_iam_role_policy_attachment" "managed_policy" {
  policy_arn = aws_iam_policy.policy.id
  role = aws_iam_role.test_role.id
}
// the below policy can be used for which specific role to be attached this policy
resource "aws_iam_role_policy_attachment" "example" {
  role       = aws_iam_role.test_role.name
  policy_arn = aws_iam_policy.policy.arn
}
