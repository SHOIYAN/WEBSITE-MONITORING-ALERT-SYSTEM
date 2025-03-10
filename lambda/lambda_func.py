import json 
import requests
import boto3
import os
from datetime import datetime, timezone

# aws resources
dynamodb = boto3.resource('dynamodb')
sns = boto3.client('sns')

# environment variables
DYNAMODB_TABLE = os.getenv('DYNAMODB_TABLE','TanaMonitoring')
SNS_TOPIC_ARN = os.getenv('SNS_TOPIC_ARN')

def check_website():
    return False  # Force website check to fail


def log_status(status):
    """Logs website status to Dynamodb with a timestamp"""
    table = dynamodb.Table(DYNAMODB_TABLE)
    timestamp = datetime.now(timezone.utc).isoformat()

    table.put_item(
        Item = {
            'timestamp': timestamp,
            'status': status
        }
    )

def send_alert ():
    """Sends an SNS notification if the website is down"""
    message = '⚠️ ALERT: TanaTech.io is DOWN!'

    if SNS_TOPIC_ARN:
        sns.publish(
            TopicArn = SNS_TOPIC_ARN,
            Message = message,
            Subject = 'Tana Website Down'
        )

def lambda_handler (event,context):
    """Aws Lambda entry point"""
    website_is_up = check_website()
    log_status(website_is_up)

    if not website_is_up:
        send_alert()
    return {
        'statusCode': 200,
        'body': json.dumps({'website_up': website_is_up})
    }
