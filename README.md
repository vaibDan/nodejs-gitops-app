# GitOps CI/CD with Argo CD and GitHub Actions

This repository contains the source code for a simple Node.js application and the CI pipeline responsible for its automated deployment. It is the application component of a complete, resume-worthy GitOps project.

### Project Status & Tech Stack

[![CI - Build and Push Docker Image](https://github.com/vaibDan/nodejs-gitops-app/actions/workflows/ci.yml/badge.svg)](https://github.com/vaibDan/nodejs-gitops-app/actions/workflows/ci.yml)
[![Argo CD Sync Status](https://img.shields.io/badge/ArgoCD%20Sync-Synced%20%26%20Healthy-success?style=flat&logo=argo)](http://localhost:8080/applications/nodejs-app)

![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Argo CD](https://img.shields.io/badge/Argo%20CD-F48024?style=for-the-badge&logo=argo&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)

---

## Project Overview & Architecture

This project demonstrates a secure, modern GitOps workflow using a two-repository model. This approach separates application code from deployment configuration, enhancing security and auditability.

*   **Application Repository (this one):** Contains application code, Dockerfile, and the CI pipeline.
*   **[Manifests Repository](https://github.com/vaibDan/nodejs-gitops-manifests):** Contains the Kubernetes YAML manifests that define the desired state of the application. It is the single source of truth for deployments.

### End-to-End Workflow

The diagram below illustrates the entire automated process, from a code commit to a live deployment.

```mermaid
graph TD
    A[Developer<br/>git push] --> B{Application Repo<br/>(nodejs-gitops-app)};
    B --> C{{GitHub Actions<br/>CI Pipeline}};
    C -->|1. Test & Build| D[(Docker Image)];
    C -->|2. Push Image| E[Container Registry<br/>(Docker Hub)];
    C -->|3. Update Manifest| F{Manifests Repo<br/>(nodejs-gitops-manifests)};
    G{Argo CD<br/>(Pulling every 3 mins)} --> F;
    F -->|Detects Change| G;
    G -->|Pulls & Applies<br/>New Manifest| H([Kubernetes Cluster]);
    H -->|Pulls New Image| E;

    style G fill:#F48024,stroke:#333,stroke-width:2px,color:#fff
    style H fill:#326CE5,stroke:#333,stroke-width:2px,color:#fff
```

## How to Replicate

To set up this project yourself, you will need:
*   Two GitHub Repositories (one for app, one for manifests).
*   A Kubernetes Cluster (Minikube was used here).
*   `kubectl`, `docker`, and `minikube` CLIs installed.
*   Argo CD installed in the cluster.
*   A Docker Hub account.

The detailed, step-by-step instructions for building this project from scratch are outlined in the tutorial that guided its creation.