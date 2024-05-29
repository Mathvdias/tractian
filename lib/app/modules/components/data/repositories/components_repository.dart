import 'package:multiple_result/multiple_result.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/components/data/adapters/request_components_list_adapter.dart';
import 'package:tractian/app/modules/components/interactor/interactor.dart';
import 'package:tractian/app/modules/components/interactor/repositories/i_components_repository.dart';

final class ComponentsRepository extends IComponentsRepository {
  final IRestClient restClient;

  ComponentsRepository(this.restClient);

  @override
  Future<Output<RequestComponentsListEntity>> call(String companyId) async {
    try {
      final response =
          await restClient.get(RestClientRequest(path: env.assets(companyId)));

      return Success(RequestComponentsListAdapter.fromJson(response.data));
    } on RestClientException catch (e) {
      return Error(e);
    }
  }
}
