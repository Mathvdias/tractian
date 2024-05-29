import 'package:tractian/app/core/core.dart';

abstract interface class IRestClient {
  Future<RestClientResponse> post(RestClientRequest request);

  Future<RestClientResponse> get(RestClientRequest request);

  void addInterceptors(IClientInterceptor interceptor);

  void removeInterceptors(IClientInterceptor interceptor);
}
