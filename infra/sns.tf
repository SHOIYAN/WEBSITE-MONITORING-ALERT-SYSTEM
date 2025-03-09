resource "aws_sns_topic" "tana_alerts" {
  name = "tana-monitoring-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.tana_alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com" 
}
