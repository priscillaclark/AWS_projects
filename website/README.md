# 🧪 Website Hosting Simulation with S3 + LocalStack

This folder simulates hosting a static website on Amazon S3 using LocalStack and AWS CLI.

## 🔧 Steps

1. Create a bucket called `my-static-site`
2. Upload `index.html`
3. Configure the bucket for static website hosting
4. Apply a public-read bucket policy

Run all steps with:

```bash
./deploy-site.sh
```

Note: LocalStack does not serve real web content via browser, but you can verify everything was configured correctly via AWS CLI.
