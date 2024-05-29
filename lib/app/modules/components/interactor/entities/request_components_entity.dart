import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/core/entities/request/request_components_entity.dart';

final class RequestComponentsListEntity extends Entity {
  final List<RequestComponentsEntity> requests;

  RequestComponentsListEntity({required this.requests}) : super('');
}
