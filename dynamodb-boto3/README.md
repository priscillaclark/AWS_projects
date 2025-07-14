# 📌 DynamoDB + Boto3 with LocalStack

This project simulates interactions with AWS DynamoDB using Python and Boto3 in a local development environment powered by LocalStack.

### 🎯 Objective

Practice working with DynamoDB tables programmatically, including creating tables, inserting items, querying data, and applying simple tests — all locally, with no AWS charges.

---


## 📥 Python Environment Setup (WSL)

Modern Linux systems (like WSL) protect the global Python environment. A virtual environment is required to safely install packages like `boto3` without system-level restrictions.

Follow these steps inside the project root (`dynamodb-boto3/`):

### 1. Install venv (if not already installed)

```bash
sudo apt update
sudo apt install python3-venv -y
````

### 2. Create a virtual environment

```bash
python3 -m venv .venv
```

### 3. Activate the environment

```bash
source .venv/bin/activate
```

You’ll see `(.venv)` at the beginning of your terminal prompt — that means the environment is active.

### 4. Install required packages

```bash
pip install boto3
```

To save the installed packages:

```bash
pip freeze > requirements.txt
```

### 5. Run your scripts

Now you can run any Python script (e.g., to create a DynamoDB table):

```bash
python scripts/create_table.py
```

### 🔄 Deactivate when done

```bash
deactivate
```

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
│   └── test_dynamo_ops.py       # Optional tests (pytest or plain assertions)
├── docker-compose.yml           # Runs LocalStack with DynamoDB
├── requirements.txt             # Python dependencies
└── README.md                    # This file
```

---

## 🚀 How to Run

1. Start LocalStack:

```bash
cd docker
docker compose up -d
```

<details>

docker-compose uses a YAML file (docker-compose.yml) to define services and environment variables.

This lets you specify exactly which AWS services to start (SERVICES=dynamodb).

You can easily add or remove services without changing the command.

Using -d (detached mode) runs the container in the background, so your terminal is free.
</details>

2. Activate virtual environment:

```bash
source .venv/bin/activate
```

*For details see Python Environment Setup (WSL) above*

3. Run the scripts:

```bash
python scripts/create_table.py
python scripts/seed_data.py
python scripts/query_data.py
```

