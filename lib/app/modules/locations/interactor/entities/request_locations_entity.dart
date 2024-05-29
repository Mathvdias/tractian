import 'package:tractian/app/core/core.dart';

import '../../../../core/entities/request/request.dart';

final class RequestLocationsListEntity extends Entity {
  final List<RequestLocationsEntity> requests;

  RequestLocationsListEntity({required this.requests}) : super('');
}
