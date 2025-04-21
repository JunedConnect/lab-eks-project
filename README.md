# Threat Composer App Deployment

This project automates the deployment of the **Threat Composer App** using **AWS**, **Terraform**, **Docker**, and **CI/CD pipelines**. Originally set up manually using **AWS Console**, the process has been automated to provide a secure, scalable, and streamlined deployment.

<br>

## Overview

The **Threat Composer App** is a containerised Node.js application deployed on **AWS EKS** using **Helm** and **Argo CD**. The deployment process is fully automated using a **CI/CD pipeline** that handles Docker image building, vulnerability scanning, and deployment to AWS through **Terraform**.

This setup uses:

**Cert Manager** to automate the issuance and renewal of TLS certificates

**Argo CD** for GitOps-based deployments, ensuring the cluster always reflects the state defined in the Git repository.

**External DNS** to dynamically manage Route 53 records based on Kubernetes ingress resources, eliminating manual DNS configuration.

**Prometheus** is used to collect cluster metrics.

**Grafana** to provide dashboards for visualising cluster metrics in real time.

<br>

## Key Components:

- **Dockerisation**: The app is containerised using a **Dockerfile** for consistency across environments.
- **Infrastructure as Code (IaC)**: Terraform provisions the following AWS resources:
    - **VPC, Subnets, NAT Gateway, and Security Groups** for network architecture.
    - **Route 53** for DNS management.
    - **Amazon EKS** for managing Kubernetes cluster.
    - **IAM Roles for Service Accounts (IRSA)** to securely allow Kubernetes service accounts to assume AWS IAM roles.
    - **Helm Charts** to deploy Argo CD, NGINX Ingress, Cert Manager, External DNS, Prometheus & Grafana.
- **CI/CD Pipeline**: GitHub Actions automate:
    - **Building and pushing the Docker image** to **Amazon ECR**.
    - **Performing security and compliance scans** to ensure code quality and security.
    - **Applying Terraform** to deploy or update AWS infrastructure.
    - **Deploying Kubernetes manifests and Helm charts**.
    - **Destroying Terraform resources** when necessary.

<br>

## Directory Structure

```
./
├── .github
│   └── workflows
│       ├── DockerBuild&Deploy.yml
│       ├── TerraformPlan.yml
│       ├── TerraformApply.yml
│       └── TerraformDestroy.yml
├── app
│   └── Dockerfile
├── argocd
│   ├── apps
│   │   └── app.yml
│   └── argocd-git.yml
├── cert-man
│   └── issuer.yml
├── terraform
│   ├── helm-values
│   │   ├── argo-cd.yml
│   │   ├── cert-manager.yml
│   │   ├── external-dns.yml
│   │   └── prom-graf.yml
│   ├── eks.tf
│   ├── irsa.tf
│   ├── k8-helm.tf
│   ├── provider.tf
│   ├── route53.tf
│   ├── variables.tf
│   └── vpc.tf
└── .pre-commit-config.yaml

```

- **Docker File** (`app/`):
    - **Dockerfile**: Builds and configures the Node.js app for container deployment.

- **Argo CD Configs** (`argocd/`):
    - **apps/app.yml**: Defines Kubernetes application deployment, service, and ingress resources.
    - **argocd-git.yml**: Configures Argo CD to manage the app using GitOps.

- **Certificate Management** (`cert-man/`):
    - **issuer.yml**: Sets up a ClusterIssuer using Let's Encrypt for TLS certificates.

- **Terraform Files** (`terraform/`):
    - **eks.tf**: Creates the EKS cluster and node groups.
    - **vpc.tf**: Provisions the full VPC setup.
    - **route53.tf**: Manages DNS hosted zone.
    - **irsa.tf**: Sets up IRSA for Kubernetes resources to access to AWS services.
    - **k8-helm.tf**: Installs core Kubernetes tools via Helm.
    - **provider.tf**: Configures AWS, Kubernetes, and Helm providers.
    - **variables.tf**: Stores all Terraform variables.
    - **helm-values**: Contains Helm values for Argo CD, Cert Manager, External DNS, Prometheus & Grafana.

- **CI/CD Pipelines** (`.github/workflows/`):

<br>


## CI/CD Deployment Workflow

The deployment process is fully automated via GitHub Actions:

1. **Docker Image Build & Deployment** (`DockerBuild&Deploy.yml`):
    - Builds the Docker image.
    - Runs **Trivy** to scan for critical vulnerabilities before pushing to ECR.
    - Pushes the image to **Amazon ECR**.

2. **Terraform Plan** (`TerraformPlan.yml`):
    - Initialises the Terraform directory.
    - Previews the necessary AWS resources.
    - Runs **TFLint** to validate Terraform syntax and best practices.
    - Runs **Checkov** to scan for security issues within Terraform code.

3. **Terraform Apply** (`TerraformApply.yml`):
    - Applies the Terraform configuration.
    - Provisions the necessary AWS resources
    - Deploys Argo CD configuration for app deployment, and cert-manager issuer.

4. **Terraform Destroy** (`TerraformDestroy.yml`):
    - Destroys all AWS resources provisioned by Terraform.

<br>

To trigger any of these workflows, navigate to **GitHub Actions** and manually run the relevant workflow.

<br>

|Here’s what it will look like:|
|-------|
|Application Page:|
| ![App](https://raw.githubusercontent.com/JunedConnect/lab-eks-project/main/images/App%20Page.png) |
|SSL Certificate:|
| ![SSL](https://raw.githubusercontent.com/JunedConnect/lab-eks-project/main/images/SSL%20Certificate.png) |
|Argo CD:|
| ![ArgoCD](https://raw.githubusercontent.com/JunedConnect/lab-eks-project/main/images/ArgoCD%20Page.png) |
|Prometheus:|
| ![Prometheus](https://raw.githubusercontent.com/JunedConnect/lab-eks-project/main/images/Prometheus%20Page.png) |
|Grafana Dashboard:|
| ![Grafana](https://raw.githubusercontent.com/JunedConnect/lab-eks-project/main/images/Grafana%20Dashboard%20.png) |
|Prometheus:|