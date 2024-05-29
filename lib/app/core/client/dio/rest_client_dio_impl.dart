import 'package:dio/dio.dart';
import 'package:tractian/app/core/client/dio/client_interceptor_dio_impl.dart';
import 'package:tractian/app/core/client/dio/dio_adapter.dart';
import 'package:tractian/app/core/core.dart';


final class DioFactory {
  static Dio dio() {
    final baseOptions = BaseOptions(
      baseUrl: env.baseUrl,
      connectTimeout: Duration(milliseconds: env.connectTimeout),
      receiveTimeout: Duration(milliseconds: env.receiveTimeout),
    );
    return Dio(baseOptions);
  }
}

final class RestClientDioImpl implements IRestClient {
  final Dio _dio;

  final Map<IClientInterceptor, Interceptor> _interceptors = {};

  RestClientDioImpl({required Dio dio}) : _dio = dio;

  @override
  void addInterceptors(IClientInterceptor interceptor) {
    _interceptors[interceptor] =
        ClientInterceptorDioImpl(interceptor: interceptor);
    _dio.interceptors.add(_interceptors[interceptor]!);
  }

  @override
  void removeInterceptors(IClientInterceptor interceptor) {
    _dio.interceptors.remove(_interceptors[interceptor]);
  }

  @override
  Future<RestClientResponse> get(RestClientRequest request) async {
    try {
      final response = await _dio.get(
        request.path,
        queryParameters: request.queryParameters,
        options: Options(
          headers: request.headers,
        ),
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  @override
  Future<RestClientResponse> post(RestClientRequest request) async {
    try {
      final response = await _dio.post(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(
          headers: request.headers,
        ),
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }
}
