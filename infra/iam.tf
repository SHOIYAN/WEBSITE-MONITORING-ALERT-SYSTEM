resource "aws_iam_role" "lambda_role" {
  name = "tana_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "lambda_basic_execution"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Allows Lambda to write to DynamoDB
resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "LambdaDynamoDBPolicy"
  description = "Allows Lambda to write to DynamoDB"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "dynamodb:PutItem"
        Resource = aws_dynamodb_table.monitoring_table.arn
      }
    ]
  })
}

# Attach policy to Lambda IAM role
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}

resource "aws_iam_policy" "lambda_sns_policy" {
  name        = "LambdaSNSPublishPolicy"
  description = "Allow Lambda to publish messages to SNS"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sns:Publish"
        Resource = "arn:aws:sns:us-east-1:888577021051:tana-monitoring-alerts"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_sns_attachment" {
  policy_arn = aws_iam_policy.lambda_sns_policy.arn
  role       = aws_iam_role.lambda_role.name
}
