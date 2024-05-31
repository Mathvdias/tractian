import 'dart:convert';
import 'package:tractian/app/core/entities/entities.dart';
import 'package:tractian/app/modules/components/interactor/interactor.dart';

class RequestComponentsListAdapter {
  static RequestComponentsListEntity fromJson(dynamic json) {
    var data = json as List<dynamic>;

    var requests = data.map((entity) {
      return RequestComponentsEntity(
        gatewayId: entity['gatewayId'] ?? '',
        id: entity['id'] ?? '',
        locationId: entity['locationId'] ?? '',
        name: entity['name'] ?? '',
        parentId: entity['parentId'] ?? '',
        sensorId: entity['sensorId'] ?? '',
        sensorType: entity['sensorType'] ?? '',
        status: entity['status'] ?? '',
      );
    }).toList();

    return RequestComponentsListEntity(
      requests: requests,
    );
  }
}

RequestComponentsListEntity parseJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return RequestComponentsListAdapter.fromJson(jsonData);
}
