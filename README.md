# ☁️ AWS Projects Collection

Welcome to the AWS Projects Collection! This repo holds multiple hands-on AWS-related projects for learning, testing, and development. Each project is self-contained with its own code, configs, and documentation.

## 🗂️ Projects Index

| Project | Description |
|---------|-------------|
| [LocalStack Tool](./localstack_tool) | Docs for LocalStack tool |
| [Lab Environment Setup](./lab_environment_setup) | Docs and Requirements for Lab development environment |
| [AWS CLI Setup Script](./aws_cli_setup_script)  | Local S3 simulation with AWS CLI, LocalStack, and Podman |
| [Website](./website) | Hosting a static website using Amazon S3 |
| [DynamoDB + Boto3 with LocalStack](./dynamodb-boto3) | DynamoDB using Python and Boto3 in a local development environment powered by LocalStack |

## 🧰 General Requirements

- [Git](https://git-scm.com/)
- [Podman Desktop](https://podman-desktop.io/downloads/windows)
- WSL2 (for Windows users)
- Basic AWS knowledge

## 📚 How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/priscillaclark/AWS_projects.git
   cd AWS_projects
   ```

## 🛠️ Repository tree (current)

 ```bash
AWS_projects
.
├── README.md
├── aws_cli_setup_script
│   ├── README.md
│   ├── docs
│   ├── localstack
│   ├── src
│   │   └── lab-setup.sh
│   └── tests
├── dynamodb-boto3
│   ├── README.md
│   ├── docker-compose.yml
│   ├── requirements.txt
│   ├── scripts
│   │   ├── __init__.py
│   │   ├── __pycache__
│   │   │   ├── __init__.cpython-312.pyc
│   │   │   ├── create_table.cpython-312.pyc
│   │   │   ├── query_data.cpython-312.pyc
│   │   │   └── seed_data.cpython-312.pyc
│   │   ├── create_table.py
│   │   ├── query_data.py
│   │   └── seed_data.py
│   ├── src
│   │   ├── __init__.py
│   │   ├── __pycache__
│   │   │   ├── __init__.cpython-312.pyc
│   │   │   └── dynamo_client.cpython-312.pyc
│   │   └── dynamo_client.py
│   └── tests
│       ├── __init__.py
│       ├── __pycache__
│       │   ├── __init__.cpython-312.pyc
│       │   └── test_dynamo_ops.cpython-312.pyc
│       └── test_dynamo_ops.py
├── lab_environment_setup
│   └── README.md
├── localstack_tool
│   ├── README.md
│   ├── docs
│   ├── localstack
│   └── src
└── website
    ├── README.md
    ├── bucket-policy.json
    ├── deploy-site.sh
    ├── index.html
    └── website-config.json
```


______________________________________________________________________
