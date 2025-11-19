# Node.js GitOps Application
[![CI - Build and Push Docker Image](https://github.com/vaibDan/nodejs-gitops-app/actions/workflows/ci.yml/badge.svg)](https://github.com/vaibDan/nodejs-gitops-app/actions/workflows/ci.yml)


This repository contains the source code for a simple Node.js application and the CI pipeline responsible for building and publishing its Docker image. It is part of a larger GitOps workflow that demonstrates modern, automated deployment practices.

## Project Architecture

Developer → GitHub → GitHub Actions → Docker Hub
                                    ↓
                        GitOps Manifests Repo
                                    ↓
                              ArgoCD → Kubernetes


This project utilizes a two-repository GitOps model to separate application concerns from operational (deployment) concerns.

*   **Application Repository (this one):** Contains application code, Dockerfile, and the CI pipeline.
*   **[Manifests Repository](https://github.com/vaibDan/nodejs-gitops-manifests):** Contains the Kubernetes YAML manifests that define the desired state of the application in the cluster. It is the single source of truth for deployments.



## The CI/CD Workflow

1.  A developer pushes a code change to the `main` branch of this repository.
2.  A GitHub Actions workflow is triggered.
3.  The workflow tests the code (if tests were added), builds a new Docker image, and tags it with the unique Git commit SHA.
4.  The newly built image is pushed to Docker Hub.
5.  The CI pipeline then checks out the [Manifests Repository](https://github.com/vaibDan/nodejs-gitops-manifests).
6.  It updates the `deployment.yaml` file, changing the `image:` tag to the new version it just built.
7.  This change is committed and pushed back to the Manifests Repository.
8.  Argo CD, running in the Kubernetes cluster, detects this change in the Manifests Repo.
9.  Argo CD automatically "pulls" the new configuration and applies it to the cluster, triggering a safe, rolling deployment of the new application version.

### How to Run Locally

1.  Clone the repository.
2.  Install dependencies: `npm install`
3.  Run the application: `npm start`
4.  Build the Docker image: `docker build -t nodejs-gitops-app .`