resource "aws_ssm_parameter" "acm_expense_arn" {
  name  = "/${var.project}/${var.environment}/acm_expense_arn"
  type  = "String"
  value = aws_acm_certificate.expense.arn
}