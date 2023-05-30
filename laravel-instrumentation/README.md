# Laravel-Instrumentation

## Manual Instrumentation
### Install package
- composer.json
    ```php
    "require": {
        "google/protobuf": "^3.22",
        "open-telemetry/api": "^1.0",
        "open-telemetry/exporter-otlp": "^1.0@beta",
        "open-telemetry/sdk": "^1.0",
        "php-http/guzzle7-adapter": "^1.0",
    },
    ```
### Set Trace in Provider
- app/Providers/OpenTelemetryServiceProvider.php
    ```php
    <?php
    namespace App\Providers;

    use Illuminate\Support\ServiceProvider;
    use OpenTelemetry\Contrib\Otlp\OtlpHttpTransportFactory;
    use OpenTelemetry\Contrib\Otlp\SpanExporter;
    use OpenTelemetry\SDK\Trace\SpanProcessor\SimpleSpanProcessor;
    use OpenTelemetry\API\Trace\Span;
    use OpenTelemetry\SDK\Trace\Tracer;
    use OpenTelemetry\SDK\Trace\TracerProvider;
    use OpenTelemetry\SDK\Trace\Sampler\AlwaysOnSampler;

    /**
    * OpenTelemetryServiceProvider injects a configured OpenTelemetry Tracer into
    * the Laravel service container, so that instrumentation is traceable.
    */
    class OpenTelemetryServiceProvider extends ServiceProvider
    {
        /**
        * Publishes configuration file.
        *
        * @return void
        */
        public function boot()
        {
            $this->publishes([
                __DIR__.'/config/opentelemetry.php' => config_path('opentelemetry.php')
            ]);

            $this->mergeConfigFrom(
                __DIR__.'/config/opentelemetry.php', 'opentelemetry'
            );
        }
        
        /**
        * Make config publishment optional by merging the config from the package.
        *
        * @return void
        */
        public function register()
        {
            $this->app->singleton(Tracer::class, function () {
                return $this->initOpenTelemetry();
            });
        }

        /**
        * Initialize an OpenTelemetry Tracer with the exporter
        * specified in the application configuration.
        * 
        * @return Tracer|null A configured Tracer, or null if tracing hasn't been enabled.
        */
        private function initOpenTelemetry(): Tracer
        {
            if(!config('opentelemetry.enable')) {
                return null;
            }

            $transport = (new OtlpHttpTransportFactory())->create(config('opentelemetry.endpoint'), 'application/x-protobuf');
            $exporter = new SpanExporter($transport);
            $provider = new TracerProvider(
                new SimpleSpanProcessor($exporter),
                // new AlwaysOnSampler(),
            );
            return $provider->getTracer('io.opentelemetry.contrib.php');
        }
    }
    ```
- config/app.php
    ```php
    'providers' => [
        App\Providers\OpenTelemetryServiceProvider::class,
    ],
    ```

### Set Middleware
- app/Http/Middleware/Trace.php
    ```php
    <?php
    namespace App\Http\Middleware;

    use Closure;
    use Illuminate\Http\Request;
    use Illuminate\Http\Response;
    use Illuminate\Routing\Router;
    use OpenTelemetry\API\Trace\Span;
    use OpenTelemetry\SDK\Trace\Tracer;

    /**
    * Trace an incoming HTTP request
    */
    class Trace
    {
        /**
        * @var Tracer $tracer OpenTelemetry Tracer
        */
        private $tracer;

        public function __construct(Tracer $tracer)
        {
            $this->tracer = $tracer;
            print('middleware<br>');
        }

        /**
        * Handle an incoming request.
        *
        * @param  Request  $request
        * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
        * @return mixed
        */
        public function handle(Request $request, Closure $next)
        {
            $rootSpan = $this->tracer->spanBuilder(strtolower($request->url()))->startSpan();
            $rootScope = $rootSpan->activate();

            $response = $next($request);

            $this->addRequestTags($rootSpan, $request);
            $this->setResponseTags($rootSpan, $response);
            
            $rootSpan->end();
            $rootScope->detach();

            return $response;
        }

        private function addRequestTags(Span $span, Request $request)
        {
            $span->setAttribute('request.url', $request->fullUrl()); // "http://10.4.2.234:8000/hello"
            $span->setAttribute('request.host', $request->host()); // "10.4.2.234"
            $span->setAttribute('request.httpHost', $request->httpHost()); // "10.4.2.234:8000"
            $span->setAttribute('request.schemeAndHttpHost', $request->schemeAndHttpHost()); // "http://10.4.2.234:8000"
            $span->setAttribute('request.path', $request->path()); // "hello"
            $span->setAttribute('request.method', $request->method());
            $span->setAttribute('request.route.action', $request->route()->getActionName()); // "App\Http\Controllers\HelloController@index"
            $span->setAttribute('request.ip', $request->ip());
            $span->setAttribute('request.userAgnet', $request->userAgent());
            
            if($request->user()) {
                $span->setAttribute('request.user', $request->user()->email);
            }
        }

        private function setResponseTags(Span $span, $response)
        {
            $span->setAttribute('response.status', $response->status());
        }
    }
    ```
- app/Http/Kernel.php
    ```php
    protected $middlewareGroups = [
        'web.trace' => [
            'trace',
        ],
    ];

    protected $routeMiddleware = [
        'trace' => \App\Http\Middleware\Trace::class,
    ];
    ```
- routes/web.php
    ```php
    Route::middleware('web.trace')->group(function () {
        ...
    });    
    ```

## Auto Instrumentation
GitHub Resource: [contrib-auto-laravel](https://github.com/opentelemetry-php/contrib-auto-laravel)
- install
    ```shell
    php pickle.phar (?)

    sudo vim /etc/php.ini
    # Add the extension to your php.ini file:
    [opentelemetry]
    extension=opentelemetry.so
    # check
    php -i | grep opentelemetry

    sudo pecl install channel://pecl.php.net/opentelemetry-1.0.0beta4
    composer require open-telemetry/opentelemetry-auto-laravel
    ```
- composer.json
    ```php
    "autoload": {
        "files": [
            "otel_autoload.php"
        ],
    },
    "autoload-dev": {
        "files": [
            "otel_autoload.php"
        ],
    },
    ```
    ```bash
    composer dump-autoload
    ```
- otel_oauload.php
    ```php
    ```

## Other
- Get current Trace and build child span
    ```php
    use OpenTelemetry\API\Common\Instrumentation\CachedInstrumentation;
    use OpenTelemetry\API\Trace\Span;
    use OpenTelemetry\API\Trace\SpanKind;
    use OpenTelemetry\Context\Context;

    $instrumentation = new CachedInstrumentation('io.opentelemetry.contrib.php.laravel');
    $builder = $instrumentation->tracer()
        ->spanBuilder("childSpan")
        ->setSpanKind(SpanKind::KIND_SERVER);
    $parent = Context::getCurrent();
    $span = $builder->setParent($parent)->setAttribute('test', 'hi')->startSpan();
    ```
- Get current Span
    ```php
    $span = Span::getCurrent();
    $span->setAttribute("Test", "GET");
    ```
- Propagation
    - Server Side
        ```php
        $carrier = [];
        TraceContextPropagator::getInstance()->inject($carrier);
        ```
        - Add in header
        ```
        'headers' => [
            'traceparent'   => $carrier['traceparent'],
        ],
        ```

## Troubleshooting
- Modify Service Name in Grafana
    - modify `name` in `composer.json`
    - modify `name` in `./vendor/composer/installed.php`
        - if you run the composer install before modify `composer.json`
