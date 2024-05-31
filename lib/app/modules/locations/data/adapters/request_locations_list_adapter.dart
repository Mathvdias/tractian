import 'package:tractian/app/core/entities/entities.dart';
import 'package:tractian/app/modules/locations/interactor/entities/request_locations_entity.dart';

final class RequestLocationsListAdapter {
  static RequestLocationsListEntity fromJson(dynamic json) {
    var data = json as List<dynamic>;

    var requests = data.map((entity) {
      return RequestLocationsEntity(
        id: entity['id'] ?? '',
        name: entity['name'] ?? '',
        parentId: entity['parentId'] ?? '',
      );
    }).toList();

    return RequestLocationsListEntity(
      requests: requests,
    );
  }
}
