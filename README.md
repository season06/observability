## Install otel-collector with helm
```bash
helm repo add open-telemetry/opentelemetry-collector https://open-telemetry.github.io/opentelemetry-helm-charts -n o11y
helm repo update
helm search repo telemetry

helm install otel-collector open-telemetry/opentelemetry-collector -f otel-collector.yml -n o11y

kubectl get all -n o11y

# delete
helm uninstall otel-collector -n o11y
```

## Install grafana tempo with helm
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo grafana

helm install tempo bitnami/grafana-tempo -f tempo.yml -n o11y

kubectl get all -n o11y

# delete
helm uninstall tempo -n o11y
```