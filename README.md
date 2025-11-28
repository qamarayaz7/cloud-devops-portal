# Cloud DevOps Portfolio Website

A production-ready static website deployed on AWS using Infrastructure as Code and CI/CD automation.

## 🚀 Live Demo
[Visit My Website](https://your-cloudfront-url.cloudfront.net)

## 🛠️ Architecture

Users → CloudFront CDN (Global) → S3 Bucket → Secure HTTPS Delivery


## 📁 Infrastructure as Code
- **Terraform** for AWS resource management
- **Remote State** in S3 for team collaboration  
- **Automated deployments** via GitHub Actions

## 🔧 AWS Services Used
- Amazon S3 (Static Website Hosting)
- Amazon CloudFront (Global CDN)
- AWS IAM (Security & Permissions)
- AWS Certificate Manager (SSL/TLS)

## ⚡ CI/CD Pipeline
- Automated testing and deployment on every `git push`
- Infrastructure changes tracked and versioned
- Zero-downtime deployments

## 🎯 Skills Demonstrated
- Infrastructure as Code (Terraform)
- DevOps CI/CD Practices
- Cloud Security & Best Practices
- AWS Service Integration
- Git Version Control

## 📂 Project Structure

├── .github/workflows/deploy.yml # CI/CD Pipeline
├── main.tf # Terraform Infrastructure
├── providers.tf # Terraform Providers
├── index.html # Website Content
└── README.md # This file


## 🚀 Quick Start
```bash
git clone https://github.com/yourusername/your-repo.git
cd your-repo
terraform init
terraform plan
terraform apply


---


**Save this as `README.md` and push with:**

```bash
git add README.md
git commit -m "docs: add README [skip ci]"
git push
