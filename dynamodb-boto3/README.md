# 📌 DynamoDB + Boto3 with LocalStack

This project simulates interactions with AWS DynamoDB using Python and Boto3 in a local development environment powered by **LocalStack**.

---

## 🎯 Objective

Practice working with DynamoDB tables **programmatically**, including:
- Creating tables
- Inserting items
- Querying data
- Writing simple tests

All of this happens **locally**, with no AWS charges or credentials needed.

---

## 🐍 Python Environment Setup (WSL)

Modern Linux systems like **WSL** protect the global Python installation. To safely install libraries like `boto3`, we use a **virtual environment**.

### Steps:

```bash
# 1. Install venv (if needed)
sudo apt update
sudo apt install python3-venv -y

# 2. Create virtual environment
python3 -m venv .venv

# 3. Activate the environment
source .venv/bin/activate

# 4. Install dependencies
pip install boto3
pip freeze > requirements.txt

# 5. Run scripts (example)
python scripts/create_table.py

# Deactivate when finished
deactivate
````

> ✅ You’ll know the environment is active when you see `(.venv)` in your prompt.

---

## 📁 Project Structure

```
project02-dynamodb-boto3/
├── src/
│   └── dynamo_client.py         # DynamoDB client setup
├── scripts/
│   ├── create_table.py          # Create table
│   ├── seed_data.py             # Insert fake users
│   └── query_data.py            # Retrieve data
├── tests/
│   └── test_dynamo_ops.py       # Optional tests
├──  docker-compose.yml          # LocalStack configuration
├── requirements.txt             # Python dependencies
└── README.md                    # This file
```

---

## 🚀 How to Run

### ✅ Step 0: Create project structure

```bash
mkdir -p AWS_projects/dynamodb-boto3/{src,scripts,tests}
cd AWS_projects/dynamodb-boto3
```

---

### ✅ Step 1: Start LocalStack with DynamoDB

Create `docker/docker-compose.yml`:

```yaml
version: '3.8'
services:
  localstack:
    image: localstack/localstack
    ports:
      - "4566:4566"
    environment:
      - SERVICES=dynamodb
      - AWS_DEFAULT_REGION=us-east-1
```

Run LocalStack:

```bash
docker compose -f docker-compose.yml up -d
```

<details>
<summary>Why docker-compose?</summary>

* Lets you specify AWS services (e.g. `SERVICES=dynamodb`)
* Easily add/remove services without changing the command
* `-d` means detached mode (run in background)

</details>

#### 🛑 Free port 4566 if needed

Check running containers:

```bash
docker ps
```

Stop any container using port 4566:

```bash
docker stop <container_id_or_name>
```

---

## 🧰 DynamoDB Client Setup

📄 `src/dynamo_client.py`

```python
import boto3

def get_dynamo_client():
    return boto3.client(
        'dynamodb',
        endpoint_url='http://localhost:4566',
        region_name='us-east-1',
        aws_access_key_id='test',
        aws_secret_access_key='test'
    )
```

Also run:

```bash
touch src/__init__.py
touch scripts/__init__.py
touch tests/__init__.py
```

> These files allow Python to treat the folders as packages and support `-m module.path` execution.

---

## ✅ Create Table with Boto3

📄 `scripts/create_table.py`

```python
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
```

Run:

```bash
python3 -m scripts.create_table
```

---

## ✅ Insert Sample Data

📄 `scripts/seed_data.py`

```python
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
```

Run:

```bash
python3 -m scripts.seed_data
```

---

## ✅ Query the Table

📄 `scripts/query_data.py`

```python
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
```

Run:

```bash
python3 -m scripts.query_data
```

---

## ✅ (Optional) Run Tests

📄 `tests/test_dynamo_ops.py`

```python
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
```

Run:

```bash
python3 -m tests.test_dynamo_ops
```

---

## 🧪 Bonus: Check if table was created

```bash
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
```


