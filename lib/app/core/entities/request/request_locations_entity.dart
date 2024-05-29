import 'package:tractian/app/core/core.dart';

final class RequestLocationsEntity extends Entity {
  final String name;
  final String companyId;
  RequestLocationsEntity({
    required String id,
    required this.name,
    required this.companyId,
  }) : super(id);
}
