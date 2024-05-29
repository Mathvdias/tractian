import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/home/interactor/entities/request_list_entity.dart';

abstract class IHomeRepository {
  Future<Output<RequestListEntity>> call();
}
