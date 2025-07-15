from src.dynamo_client import get_dynamo_client

dynamodb = get_dynamo_client()

def test_table_exists():
    tables = dynamodb.list_tables()
    assert "Users" in tables["TableNames"]
    print("✅ Table exists test passed.")

def test_items_count():
    response = dynamodb.scan(TableName="Users")
    assert len(response["Items"]) == 5
    print("✅ Item count test passed.")

def test_get_specific_user():
    response = dynamodb.get_item(
        TableName="Users",
        Key={"user_id": {"S": "u001"}}
    )
    assert "Item" in response
    print("✅ Specific user test passed.")

if __name__ == "__main__":
    test_table_exists()
    test_items_count()
    test_get_specific_user()
