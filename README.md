# 🚀 Project 4: Deploy Prometheus and Grafana on Kubernetes Cluster using Terraform & Helm

## 🔍 Objective
To set up a robust and scalable monitoring and visualization solution using **Prometheus** and **Grafana** on a Kubernetes cluster, automated via **Terraform** and **Helm**.

This project aims to:
- Provision a Kubernetes cluster using Terraform
- Deploy Prometheus and Grafana using Helm charts
- Automate the setup with Terraform's Helm provider
- Configure Grafana to visualize metrics from Prometheus

---

## 📘 Introduction
Modern DevOps practices rely heavily on observability to ensure reliability and performance. In this project, **Prometheus** and **Grafana** are deployed as a monitoring stack on a Kubernetes cluster. The deployment leverages **Infrastructure as Code (IaC)** tools like Terraform and Helm to ensure consistency, repeatability, and automation.

---

## 🧰 Requirements

| Component              | Details                             |
|------------------------|-------------------------------------|
| OS                     | Ubuntu 22.04                        |
| Kubernetes             | Minikube (or EKS/GKE/AKS)           |
| Terraform              | v1.5+                               |
| Helm                   | v3.x                                |
| Docker                 | Latest                              |
| kubectl                | Configured with cluster access      |

---

## 🏗️ Technology Stack

- **Operating System**: Ubuntu 22.04 LTS  
- **Container Engine**: Docker  
- **Kubernetes**: Minikube (local) / EKS (cloud)  
- **IaC Tool**: Terraform  
- **Package Manager**: Helm  
- **Monitoring**: Prometheus  
- **Visualization**: Grafana  

---

## 🛠️ Implementation Steps

### Step 1: Set up Kubernetes Cluster (Minikube or Cloud)

minikube start --driver=docker
kubectl get nodes
Step 2: Install Helm

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
Step 3: Add Repositories

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
Step 4: Deploy Prometheus and Grafana using Helm

helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace
helm install grafana grafana/grafana --namespace monitoring
Step 5: Access Prometheus and Grafana

# Port-forward Prometheus
kubectl port-forward svc/prometheus-server -n monitoring 9090:80

# Port-forward Grafana
kubectl port-forward svc/grafana -n monitoring 3000:80

# Get Grafana password
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode
Step 6: Use Terraform to Deploy Helm Charts

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  namespace  = "monitoring"
  create_namespace = true
}

resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "monitoring"
}

Run:
terraform init
terraform apply


🧱 Architecture Diagram
pgsql
Copy
Edit
+--------------------+
|    Terraform       |
|  - Provisions K8s  |
|  - Deploys Helm    |
+--------------------+
         |
         v
+-----------------------------+
|     Kubernetes Cluster      |
|                             |
|  +---------------------+    |
|  | Prometheus Pod      |<-->|
|  | - Scrapes Metrics   |    |
|  | - Exposes port 9090 |    |
|  +---------------------+    |
|                             |
|  +---------------------+    |
|  | Grafana Pod         |    |
|  | - Connects to Prom. |    |
|  | - Dashboards (3000) |    |
|  +---------------------+    |
+-----------------------------+

