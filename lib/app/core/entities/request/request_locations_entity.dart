import 'package:tractian/app/core/core.dart';

final class RequestLocationsEntity extends Entity {
  final String name;
  final String parentId;
  RequestLocationsEntity({
    required String id,
    required this.name,
    required this.parentId,
  }) : super(id);
}
