// ignore_for_file: annotate_overrides

import 'package:tractian/app/core/core.dart';

class RequestComponentsEntity extends Entity {
  final String gatewayId;
  final String id;
  final String locationId;
  final String name;
  final String parentId;
  final String sensorId;
  final String sensorType;
  final String status;
  RequestComponentsEntity({
    required this.gatewayId,
    required this.id,
    required this.locationId,
    required this.name,
    required this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
  }) : super(id);
}
