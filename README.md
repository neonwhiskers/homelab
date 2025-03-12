# 🐈‍⬛ Melo's Homelab

Welcome to Melo's Homelab! This repository contains infrastructure as code (IaC) configurations, primarily written in HCL (HashiCorp Configuration Language), used to test and deploy various services and resources across different cloud providers. Currently, my focus is on experimenting with StackIT and Azure, but this may expand as I continue learning and exploring. The goal is to try out different cloud platforms, improve my automation skills, and document my findings along the way.

## Why This Repository is Public
Since I’m just testing things out and learning, having it public makes it easier to share my setup with others, get feedback, and refer back to it when needed. Plus, if someone else finds it useful, that’s a nice bonus!

In the case of StackIT, for example, there aren’t many public Terraform configurations available yet—likely because it's a B2B-focused cloud. By sharing my configurations, I hope to make it a bit easier for others who are also experimenting with it.

## Directory Structure
The repository is organized into the following main directories:
- `.github/workflows/deploy-cloud-stackit-server.yaml`: Terraform plan and apply workflow for automating StackIT server deployment.
- `cloud/stackit/server/terraform/`: Contains Terraform configurations for setting up and managing network resources, one test server with Nginx installed via cloud-init, and a security group with defined rules.
- `cloud/azure/k8s/terraform/`: Contains Terraform configurations for Kubernetes deployments on Azure (currently in development).

---

If you have any questions, feel free to reach out!

Happy coding and learning! 🚀