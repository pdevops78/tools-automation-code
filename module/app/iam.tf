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
resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
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