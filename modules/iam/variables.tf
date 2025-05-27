variable "aws_iam_policy" {
  description = "Políticas IAM a serem criadas"
  type = map(object({
    name        = string
    description = string
    statements  = list(object({
      effect    = string
      actions   = list(string)
      resources = list(string)
    }))
  }))
}

variable "aws_iam_role" {
  description = "Funções IAM a serem criadas"
  type = map(object({
    name        = string
    description = string
    assume_role_policy = string
  }))
  
}