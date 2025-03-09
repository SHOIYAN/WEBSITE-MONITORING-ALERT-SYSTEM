resource "aws_lambda_function" "tana_monitoring" {
  function_name = "TanaMonitoringFunction"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_func.lambda_handler"
  runtime       = "python3.9"
  timeout       = 10

  filename         = "../lambda/package.zip"
  source_code_hash = filebase64sha256("../lambda/package.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.monitoring_table.name
      SNS_TOPIC_ARN  = aws_sns_topic.tana_alerts.arn
    }
  }
}
