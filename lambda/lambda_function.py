import boto3
from botocore.exceptions import ClientError
import requests
import json
import os
from datetime import date
import logging


def lambda_handler(event, context):
    date_now = date.today()
    date_now_str = date_now.strftime("%y-%m-%d-%H")

    upload_bucket = os.environ['UPLOAD_BUCKET']
    logging.info(f'upload_bucket:{upload_bucket}')

    r = requests.get('https://dummyjson.com/products')

    data = r.json()
    file_name = "product-" + date_now_str + ".json"
    local_file_name = "/tmp/" + file_name

    with open(local_file_name, 'w') as f:
        json.dump(data, f)

    s3_client = boto3.client('s3')
    try:
        response = s3_client.upload_file(
            local_file_name, upload_bucket, file_name)
    except ClientError as e:
        logging.error(e)
        return False
    return True
