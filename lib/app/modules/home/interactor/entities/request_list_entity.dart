import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/core/entities/request/request_entity.dart';

final class RequestListEntity extends Entity {
  final List<RequestEntity> requests;

  RequestListEntity({required this.requests}) : super('');
}
