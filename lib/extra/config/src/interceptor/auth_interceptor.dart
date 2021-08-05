part of configuration;

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';
    options.headers['Authorization'] = 'Bearer ${BuildConfig.get().apiKey}';
    return super.onRequest(options, handler);
  }
}
