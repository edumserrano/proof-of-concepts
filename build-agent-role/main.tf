resource "aws_iam_role" "build_agent" {
  name = "build-agent"
  description = "Used by build agents to provision infrastructure and deploy applications."
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowAssumeFromEC2"
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

data "aws_iam_policy" "power_user_access" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

data "aws_iam_policy" "iam_full_access" {
  arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_role_policy_attachment" "add_iam_full_access_to_build_agent" {
  role       = aws_iam_role.build_agent.name
  policy_arn = data.aws_iam_policy.iam_full_access.arn
}

resource "aws_iam_role_policy_attachment" "add_power_user_access_to_build_agent" {
  role       = aws_iam_role.build_agent.name
  policy_arn = data.aws_iam_policy.power_user_access.arn
}

# resource "aws_iam_role_policy" "build_agent_permissions" {
#   name = "build-agent-permissions"
#   role = aws_iam_role.build_agent
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid    = "BuildAgentPermissons"
#         Action = [
#           "*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }
