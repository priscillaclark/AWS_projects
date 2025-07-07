# 🧪 Website Hosting Simulation with S3 + LocalStack

This folder simulates hosting a static website on Amazon S3 using LocalStack and AWS CLI.

## 🔧 Steps

1. Create a bucket called `new-static-site`
2. Upload `index.html`
3. Configure the bucket for static website hosting
4. Apply a public-read bucket policy

Run all steps with:

```bash
./deploy-site.sh
````

> ⚠️ Note: LocalStack does not serve real web content via browser, but you can verify everything was configured correctly via the AWS CLI.


## 📁 Folder contents

```
website/
├── index.html             # Sample HTML file to simulate the website
├── website-config.json    # S3 static website configuration
├── bucket-policy.json     # Public read policy
├── deploy-site.sh         # Script to deploy everything via AWS CLI
└── README.md              # This file
```

Check if the bucket exists:

```
aws --endpoint-url=http://localhost:4566 s3 ls
```

Create the bucket manually if needed:

```
aws --endpoint-url=http://localhost:4566 s3 mb s3://new-static-site
```

Apply the website configuration again:
```
aws --endpoint-url=http://localhost:4566 s3api put-bucket-website \
  --bucket new-static-site \
  --website-configuration file://website-config.json
```

Verify the configuration:
```
aws --endpoint-url=http://localhost:4566 s3api get-bucket-website \
  --bucket new-static-site
```
