// create a prometheus role and attach assume role policy
resource "aws_iam_role" "prometheus_role" {
  name = "${var.env}-prometheus-role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
    inline_policy {
      name = "my_inline_policy"

      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action   = ["ec2:Describe*"]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
      })
    }

}

// create an instance profile for specific role
// attach this profile to specific instance
resource "aws_iam_instance_profile" "prometheus_profile" {
  name = "${var.env}-prometheus-profile"
  role = aws_iam_role.test_role.name
}

// to allow actions inside a specific instance we use ec2:DescribeInstances
// ec2:DescribeInstances contains list of tags,public ip , private ip ,instance id,....
// we cannot reuse to any roles then we should go for inline policy and attach this inline policy directly to iam role


