# CRIAR UM POLICE
resource "aws_iam_policy" "custom_policy" {
  for_each = var.aws_iam_policy

  name        = each.value.name
  description = each.value.description

  policy = jsonencode(each.value.policy)
}

# CRIAR UM REGRA
resource "aws_iam_role" "custom_role" {
  for_each = var.aws_iam_role

  name = each.value.name
  description = each.value.description

  assume_role_policy = jsonencode(each.value.assume_role_policy)
}

# Anexa a policy personalizada ao role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.custom_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
}

# Cria um grupo IAM
resource "aws_iam_group" "create_custom_group" {
  name = "developers"
}

# Anexa uma policy gerenciada pela AWS ao grupo
resource "aws_iam_group_policy_attachment" "attachment_policy" {
  group      = aws_iam_group.dev_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# Cria um usuário IAM
resource "aws_iam_user" "create_user" {
  name = "joao.silva"
}

# Adiciona o usuário ao grupo
resource "aws_iam_user_group_membership" "add_user_to_group" {
  user = aws_iam_user.dev_user.name
  groups = [
    aws_iam_group.dev_group.name
  ]
}

