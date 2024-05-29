import 'package:tractian/app/core/core.dart';

final class RequestEntity extends Entity {
  final String name;

  RequestEntity({
    required String id,
    required this.name,
  }) : super(id);
}
