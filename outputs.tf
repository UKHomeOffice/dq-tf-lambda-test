output "lambda_subnet" {
  value = aws_subnet.lambda_subnet.id
}

output "lambda_subnet_az2" {
  value = aws_subnet.lambda_subnet_az2.id
}

output "lambda_sgrp" {
  value = aws_security_group.sgrp.id
}
