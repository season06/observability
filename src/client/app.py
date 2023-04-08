from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import SERVICE_NAME, Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.trace.propagation.tracecontext import TraceContextTextMapPropagator

from flask import Flask, request
import requests

resource = Resource(attributes={
    SERVICE_NAME: "client"
})

otlp_exporter = OTLPSpanExporter(
    endpoint="http://localhost:4317",
    insecure=True
)

provider = TracerProvider(resource=resource)
processor = BatchSpanProcessor(otlp_exporter)
provider.add_span_processor(processor)
trace.set_tracer_provider(provider)
tracer = trace.get_tracer(__name__)

app = Flask(__name__)
app.debug = True


@app.route("/test")
def test():
    with tracer.start_as_current_span(
        "server_request",
        attributes={"endpoint": "/test"}
    ):
        with tracer.start_as_current_span("connect"):
            payload = {
                'sides': int(request.args.get('sides')),
                'rolls': int(request.args.get('rolls')),
            }
            carrier = {}
            TraceContextTextMapPropagator().inject(carrier)
            print(carrier)
            r = requests.get('http://localhost:5000/roll',
                             params=payload, headers=carrier)

        return str(r.text)
