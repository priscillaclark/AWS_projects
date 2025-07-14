from src.dynamo_client import get_dynamo_client

dynamodb = get_dynamo_client()

users = [
    {"user_id": {"S": "u001"}, "email": {"S": "alice@example.com"}},
    {"user_id": {"S": "u002"}, "email": {"S": "bob@example.com"}},
    {"user_id": {"S": "u003"}, "email": {"S": "carol@example.com"}},
    {"user_id": {"S": "u004"}, "email": {"S": "dave@example.com"}},
    {"user_id": {"S": "u005"}, "email": {"S": "eve@example.com"}}
]

for user in users:
    response = dynamodb.put_item(
        TableName="Users",
        Item=user
    )
    print(f"✅ Inserted: {user['user_id']['S']}")
