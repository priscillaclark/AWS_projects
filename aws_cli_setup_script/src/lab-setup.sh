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
