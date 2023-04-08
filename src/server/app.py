from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import SERVICE_NAME, Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.trace.propagation.tracecontext import TraceContextTextMapPropagator

from flask import Flask, request
from random import randint

resource = Resource(attributes={
    SERVICE_NAME: "server"
})

# jaeger_exporter = JaegerExporter(
#     agent_host_name="localhost",
#     agent_port=6831,
# )
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

db = []


def get_header_from_flask_request(request, key):
    return request.headers.get_all(key)


@app.route("/roll")
def roll():
    traceparent = get_header_from_flask_request(request, "traceparent")
    carrier = {"traceparent": traceparent[0]}
    ctx = TraceContextTextMapPropagator().extract(carrier)
    with tracer.start_as_current_span(
        "server_request",
        attributes={"endpoint": "/roll"},
        context=ctx
    ):
        sides = int(request.args.get('sides'))
        rolls = int(request.args.get('rolls'))

        with tracer.start_as_current_span("sum"):
            sum = roll_sum(sides, rolls)

        with tracer.start_as_current_span("store"):
            store_sum(sum)

        return str(sum)


def roll_sum(sides, rolls):
    span = trace.get_current_span()

    sum = 0
    for r in range(0, rolls):
        result = randint(1, sides)
        sum += result

        span.add_event("log", {
            "roll.sides": sides,
            "roll.result": result,
        })

    return sum


def store_sum(sum):
    span = trace.get_current_span()

    db.append(sum)

    span.add_event("log", {
        "db store": str(db),
    })
