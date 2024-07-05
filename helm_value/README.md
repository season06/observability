## Install otel-collector with Helm
```bash
# add repo
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update
helm search repo open-telemetry

# install
helm install otel-collector open-telemetry/opentelemetry-collector -f otel-collector.yml -n o11y

# check
kubectl get all -n o11y
helm show values open-telemetry/opentelemetry-collector

# update
helm upgrade otel-collector open-telemetry/opentelemetry-collector -f otel-collector.yml -n o11y

# delete
helm uninstall otel-collector -n o11y
```

- ref
    - [Config OpenTelemetry Collector](https://opentelemetry.io/docs/kubernetes/helm/collector/)
    - [OpenTelemetry Collector Chart](https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-collector)

## Install Grafana Tempo with Helm
```bash
# add repo
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm search repo grafana

# install
helm install tempo grafana/tempo-distributed -f tempo.yml -n o11y

# check
kubectl get all -n o11y
helm show values grafana/tempo-distributed

# update
helm upgrade tempo grafana/tempo-distributed -f tempo.yml -n o11y

# delete
helm uninstall tempo -n o11y
```

- ref
    - [Config Grafana Tempo](https://grafana.com/docs/tempo/latest/configuration/)
    - [Get started with Grafana Tempo using the Helm chart](https://grafana.com/docs/helm-charts/tempo-distributed/next/get-started-helm-charts/)
    - [Grafana tempo-distributed Chart](https://github.com/grafana/helm-charts/tree/main/charts/tempo-distributed)

## Ref

[[Kubernetes] DNS for Service & Pod](https://godleon.github.io/blog/Kubernetes/k8s-DNS-for-Service-and-Pod/)
[When Helm refuses to delete a release](https://medium.com/@calvineotieno010/no-i-cannot-delete-it-when-helm-refuses-to-delete-a-release-ac9c64919e2b)

---

## otel-collector helm value explaination

### Batch Processor

> The batch processor accepts spans, metrics, or logs and places them into batches. Batching helps better compress the data and reduce the number of outgoing connections required to transmit the data

- send_batch_size: 達到此數量的 trace、metric、log 將立即發送。
- timeout: 經過一段時間後立即發送。若設置為 0 則忽略 batch_size，因為 data 將立即發送。

https://github.com/open-telemetry/opentelemetry-collector/tree/main/processor/batchprocessor

### Memory Limiter Processor
https://github.com/open-telemetry/opentelemetry-collector/tree/main/processor/memorylimiterprocessor

> For the memory_limiter processor, the best practice is to add it as the first processor in a pipeline.
