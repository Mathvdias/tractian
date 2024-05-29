import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian/app/core/client/dio/rest_client_dio_impl.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/modules.dart';

GetIt di = GetIt.instance;

void setup() {
  di.registerFactory<Dio>(DioFactory.dio);
  di.registerSingleton<IRestClient>(RestClientDioImpl(dio: di<Dio>()));
  di.registerFactory(() => HomeController);
  di.registerFactory<IHomeRepository>(
      () => HomeRepositoryImpl(di<IRestClient>()));
}
