import boto3
import json
s3_client = boto.client('s3')
ddb= boto3.resource('dynamodb')
def upd_ddb(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    json_fname = event['Records'][0]['s3']['object']['key']
    json_obj= s3_client.get_object(Bucket=bucket,Key=json_fname)
    jsonFReader = json_obj['Body'].read()
    jsonDict = json.loads(jsonFReader)
    table = ddb.Table('employees')
    table.put_item(Item=jsonDict)
    return 'Load completed'