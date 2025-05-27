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

    name        = each.value.name
    description = each.value.description

    assume_role_policy = jsonencode(each.value.assume_role_policy)
}

# Anexa a policy personalizada ao role
resource "aws_iam_role_policy_attachment" "attach_policy" {
    for_each = var.aws_iam_role_policy_attachment

    role       = each.value.role
    policy_arn = each.value.policy_arn
}

# Cria um grupo IAM
resource "aws_iam_group" "create_custom_group" {
    for_each = var.aws_iam_group

    id      = each.value.id
    arn     = each.value.arn
    name    = each.value.name  
    path    = each.value.path

}

# Anexa uma policy gerenciada pela AWS ao grupo
resource "aws_iam_group_policy_attachment" "attachment_policy" {
    for_each = var.aws_iam_group_policy_attachment

    group      = each.value.aws_iam_group_policy_attachment.group
    policy_arn = each.value.aws_iam_group_policy_attachment.policy_arn
}

# Cria um usuário IAM
resource "aws_iam_user" "create_user" {
    for_each = var.aws_iam_user

    name = each.value.name
}

# Adiciona o usuário ao grupo
resource "aws_iam_user_group_membership" "add_user_to_group" {
    for_each = var.aws_iam_user_group_membership

    user    = each.value.aws_iam_user_group_membership.user
    groups  = each.value.aws_iam_user_group_membership.groups
}

