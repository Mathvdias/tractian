import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/components/interactor/interactor.dart';

abstract class IComponentsRepository {
  Future<Output<RequestComponentsListEntity>> call(String companyId);
}
