resource "aws_cloudwatch_event_rule" "monitoring_schedule" {
  name                = "monitoring_schedule"
  description         = "Triggers the Lambda function every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.monitoring_schedule.name
  target_id = "TanaMonitorLambda"
  arn       = aws_lambda_function.monitoring_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.monitoring_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.monitoring_schedule.arn
}
