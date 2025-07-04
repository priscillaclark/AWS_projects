
# LocalStack + AWS CLI Setup for Local S3 Development

This guide explains how to run LocalStack using Docker and configure the AWS CLI to work with a simulated local AWS environment. It also includes an automated script to simplify environment setup.

---

## 1. Running LocalStack with Docker

Run the following command to start LocalStack, which emulates AWS services locally (such as S3):

```bash
docker run --rm -it -p 4566:4566 -p 4571:4571 localstack/localstack
````

<details>
<summary> 🔽 ### Detail for each part of the command </summary>

| Command part            | Meaning                                            |
| ----------------------- | -------------------------------------------------- |
| `docker run`            | Runs a Docker container                            |
| `--rm`                  | Automatically removes the container when it stops  |
| `-it`                   | Interactive terminal mode                          |
| `-p 4566:4566`          | Maps port 4566 (used by S3 and other services)     |
| `-p 4571:4571`          | Maps port 4571 (used by other LocalStack services) |
| `localstack/localstack` | Official LocalStack Docker image                   |

</details>

<details>
    
<summary> 🔽 ### How to Check if LocalStack is Running </summary>

### 1. Using `nc` (netcat)
Check if port 4566 is open:

```bash
nc -zv localhost 4566
```

✅ Success: LocalStack is running  
❌ Failure: It's not running

---

### 2. Using `curl`
Check the health endpoint:

```bash
curl http://localhost:4566/health
```

You’ll get a JSON with running services.

---

### 3. Using Docker or Podman
Check running containers:

```bash
docker ps | grep localstack
# or
podman ps | grep localstack
```

Shows container name, status, and port mapping.

</details>
---

## 2. Configuring AWS CLI to Use LocalStack

Open a new WSL terminal and run:

```bash
aws --version
aws configure
```

When prompted, enter:

```
AWS Access Key ID [None]: test
AWS Secret Access Key [None]: test
Default region name [None]: us-east-1
Default output format [None]: json
```

To verify the connection, run:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

If no error occurs, you are connected to your simulated LocalStack AWS environment.

---

## 3. Automated Setup Script

To make it easier to verify that LocalStack is running and to automatically configure AWS CLI, we created a script called `lab-setup.sh`:

### Create the script

Navigate to your project folder and create the script file:

```bash
cd "/mnt/c/Users/Priscilla Clark/AWS_projects/aws_cli_setup_script/src"
touch lab-setup.sh
nano lab-setup.sh
```

### Script contents

```bash
#!/bin/bash

echo "🔍 Checking if LocalStack is running..."

if nc -z localhost 4566; then
    echo "✅ LocalStack is active on port 4566"
else
    echo "❌ LocalStack doesn't appear to be running. Please open another terminal and run:"
    echo "   docker run --rm -it -p 4566:4566 docker.io/localstack/localstack"
    exit 1
fi

echo "⚙️ Configuring AWS CLI to use LocalStack..."

aws configure set aws_access_key_id test
aws configure set aws_secret_access_key test
aws configure set region us-east-1
aws configure set output json

echo "✅ AWS CLI configured for LocalStack"

# Quick test
echo "📦 Testing access to local S3:"
aws --endpoint-url=http://localhost:4566 s3 ls
```

Save and exit (`Ctrl + O`, Enter, `Ctrl + X`).

### Make the script executable

```bash
chmod +x lab-setup.sh
```

### Using the script

Each time you open a new WSL terminal, run:

```bash
cd "/mnt/c/Users/Priscilla Clark/AWS_projects/aws_cli_setup_script/src"
./lab-setup.sh
```

This will:

* Verify that LocalStack is running on port 4566
* Configure AWS CLI with fake credentials and region for LocalStack
* Test the connection to local S3

