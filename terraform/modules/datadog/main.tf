resource "helm_release" "datadog_agent" {

  name             = "datadog-agent"
  repository       = "https://helm.datadoghq.com"
  chart            = "datadog"
  version          = "3.1.1"
  namespace        = "datadog"
  create_namespace = true

  set {
    name  = "clusterName"
    value = var.cluster_id
  }

  set {
    name  = "clusterEndpoint"
    value = var.cluster_endpoint
  }

  values = compact([
    templatefile("${path.module}/datadog.yml", {
      clusterName = var.cluster_id
    })
  ])

  set_sensitive {
    name  = "datadog.apiKey"
    value = var.datadog_api_key
  }
}
