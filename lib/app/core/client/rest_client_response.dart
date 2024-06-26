import 'package:multiple_result/multiple_result.dart';
import 'package:tractian/app/core/core.dart';

final class RestClientResponse implements RestClientHttpMessage {
  dynamic data;
  int? statusCode;
  String? message;
  RestClientRequest request;

  RestClientResponse({
    this.data,
    this.statusCode,
    this.message,
    required this.request,
  });
}

typedef Output<T> = Result<T, BaseException>;
