output "prometheus_status" {
  value = helm_release.prometheus.status
}

output "grafana_status" {
  value = helm_release.grafana.status
}
