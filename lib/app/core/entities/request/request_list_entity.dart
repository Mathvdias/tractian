import 'package:tractian/app/core/entities/entity.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';

final class RequestListEntity extends Entity {
  final List<RequestEntity> requests;
  RequestListEntity(super.id, {required this.requests});
}
