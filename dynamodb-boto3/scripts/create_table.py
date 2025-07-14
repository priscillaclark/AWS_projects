from src.dynamo_client import get_dynamo_client

dynamodb = get_dynamo_client()

def create_users_table():
    try:
        response = dynamodb.create_table(
            TableName='Users',
            KeySchema=[{'AttributeName': 'user_id', 'KeyType': 'HASH'}],
            AttributeDefinitions=[{'AttributeName': 'user_id', 'AttributeType': 'S'}],
            ProvisionedThroughput={'ReadCapacityUnits': 5, 'WriteCapacityUnits': 5}
        )
        print("✅ Table created:", response['TableDescription']['TableName'])
    except dynamodb.exceptions.ResourceInUseException:
        print("⚠️ Table 'Users' already exists.")

if __name__ == "__main__":
    create_users_table()
