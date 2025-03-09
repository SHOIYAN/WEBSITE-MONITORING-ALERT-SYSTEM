resource "aws_dynamodb_table" "monitoring_table" {
  name           = "TanaMonitoring"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "timestamp"

  attribute {
    name = "timestamp"
    type = "S"
  }
}
