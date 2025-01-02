data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  depends_on = [module.eks.cluster_name]
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "7.7.11"
  create_namespace = true
}

resource "kubectl_manifest" "config" {
  yaml_body  = file("../argocd/application.yaml")
  depends_on = [helm_release.argocd,null_resource.kubectl]
}

