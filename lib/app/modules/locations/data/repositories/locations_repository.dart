import 'package:multiple_result/multiple_result.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/locations/data/adapters/request_locations_list_adapter.dart';
import 'package:tractian/app/modules/locations/interactor/entities/request_locations_entity.dart';
import 'package:tractian/app/modules/locations/interactor/repositories/i_locations_repository.dart';


final class LocationsRepositoryImpl implements ILocationsRepository {
  final IRestClient restClient;

  const LocationsRepositoryImpl(this.restClient);

  @override
  Future<Output<RequestLocationsListEntity>> call(String companyId) async {
    try {
      final response = await restClient
          .get(RestClientRequest(path: env.locations(companyId)));

      return Success(RequestLocationsListAdapter.fromJson(response.data));
    } on RestClientException catch (e) {
      return Error(e);
    }
  }
}
