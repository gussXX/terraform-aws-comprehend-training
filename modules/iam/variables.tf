# ====== POLICES =============================================
variable "aws_iam_policy" {
  description   = "Políticas IAM a serem criadas"
  type          = map(object({
    name        = string
    description = string
    statements  = list(object({
      effect    = string
      actions   = list(string)
      resources = list(string)
    }))
  }))
}
# ====== POLICES =============================================

# ====== ROLES ===============================================
variable "aws_iam_role" {
  description           = "Funções IAM a serem criadas"
  type                  = map(object({
    name                = string
    description         = string
    assume_role_policy  = string
  }))
}
# ====== ROLES ===============================================

# ====== ANEXAR POLICES A UMA ROLE ===========================
variable "aws_iam_role_policy_attachment" {
    description     = "Função que anexa uma política personalizada a uma função IAM"
    type            = map(object({
        role        = string
        policy_arn  = string
    }))
}
# ====== ANEXAR POLICES A UMA ROLE ===========================

# ====== GRUPO IAM ===========================================
variable "aws_iam_group" {
    description = "Grupos IAM a serem criados"
    type        = map(object({
        id      = string
        arn     = string
        name    = string
        path    = string
    }))
}
# ====== GRUPO IAM ===========================================

# ====== ANEXAR POLITICA CRIADA PELA AWS =====================
variable "aws_iam_group_policy_attachment" {
    description = "Anexa uma política gerenciada pela AWS a um grupo IAM"
    type        = map(object({
        group = string
        policy_arn = string
    }))
}
# ====== ANEXAR POLITICA CRIADA PELA AWS =====================

# ====== CRIAR UM USUARIO ====================================
variable "aws_iam_user" {
    description = "Usuários IAM a serem criados"
    type        = map(object({
        name = string
    }))
}
# ====== CRIAR UM USUARIO ====================================

# ====== ADICIONAR UM USER A POLICE IAM ======================
variable "aws_iam_user_group_membership" {
    description = "Adiciona um usuário a um grupo IAM"
    type        = map(object({
        user      = string
        groups     = list(string)
    }))
}
# ====== ADICIONAR UM USER A POLICE IAM ======================