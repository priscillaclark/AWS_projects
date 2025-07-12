#!/bin/bash

BUCKET_NAME="new-static-site"
ENDPOINT="http://localhost:4566"

echo "🪣 Creating bucket $BUCKET_NAME..."
aws --endpoint-url=$ENDPOINT s3 mb s3://$BUCKET_NAME || {
  echo "⚠️ Bucket may already exist or LocalStack is not running."
}

echo "⬆️ Uploading index.html..."
aws --endpoint-url=$ENDPOINT s3 cp index.html s3://$BUCKET_NAME/

echo "⚙️ Applying website config..."
aws --endpoint-url=$ENDPOINT s3api put-bucket-website \
  --bucket $BUCKET_NAME \
  --website-configuration file://website-config.json

echo "🔓 Applying public read policy..."
aws --endpoint-url=$ENDPOINT s3api put-bucket-policy \
  --bucket $BUCKET_NAME \
  --policy file://bucket-policy.json

echo "✅ Static website simulated on bucket: $BUCKET_NAME"

