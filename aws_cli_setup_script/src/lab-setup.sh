#!/bin/bash

echo "🔍 Checking if LocalStack is running..."

if nc -z localhost 4566; then
    echo "✅ LocalStack is already running on port 4566."
else
    echo "⚙️ LocalStack is not running. Starting it with docker-compose..."
    docker-compose up -d

    echo "⏳ Waiting 10 seconds for LocalStack to initialize..."
    sleep 10

    # Check again to confirm it started
    if nc -z localhost 4566; then
        echo "✅ LocalStack started successfully."
    else
        echo "❌ Failed to start LocalStack. Check docker-compose logs."
        exit 1
    fi
fi

echo "⚙️ Configuring AWS CLI to use LocalStack..."

aws configure set aws_access_key_id test
aws configure set aws_secret_access_key test
aws configure set region us-east-1
aws configure set output json

echo "✅ AWS CLI configured for LocalStack."

# Quick test
echo "📦 Testing access to local S3:"
aws --endpoint-url=http://localhost:4566 s3 ls
