from src.dynamo_client import get_dynamo_client

dynamodb = get_dynamo_client()

user_id_to_query = "u003"

response = dynamodb.get_item(
    TableName="Users",
    Key={"user_id": {"S": user_id_to_query}}
)

item = response.get("Item")
if item:
    print("✅ User found:")
    print(item)
else:
    print("❌ User not found.")
