import 'package:tractian/app/core/entities/request/request_entity.dart';
import 'package:tractian/app/modules/home/interactor/entities/request_list_entity.dart';

final class RequestListAdapter {
  static RequestListEntity fromJson(dynamic json) {
    var data = json as List<dynamic>;

    var requests = data.map((entity) {
      return RequestEntity(
        id: entity['id'],
        name: entity['name'],
      );
    }).toList();

    return RequestListEntity(
      requests: requests,
    );
  }
}
