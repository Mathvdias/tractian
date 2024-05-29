import 'package:multiple_result/multiple_result.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/home/data/adapters/request_list_adapter.dart';
import 'package:tractian/app/modules/home/interactor/entities/request_list_entity.dart';
import 'package:tractian/app/modules/home/interactor/repositories/i_home_repository.dart';

var env = Env();

class HomeRepositoryImpl implements IHomeRepository {
  final IRestClient restClient;

  const HomeRepositoryImpl(this.restClient);

  @override
  Future<Output<RequestListEntity>> getCompanies() async {
    try {
      final response =
          await restClient.get(RestClientRequest(path: env.companies));

      return Success(RequestListAdapter.fromJson(response.data));
    } on RestClientException catch (e) {
      return Error(e);
    }
  }
}
