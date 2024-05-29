import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/localizations/interactor/entities/request_locations_entity.dart';

abstract class ILocationsRepository {
  Future<Output<RequestLocationsListEntity>> call(String companyId);
}
