import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/modules.dart';

class LocationsController extends BaseController<BaseState> {
  final ILocationsRepository _localizationsRepository;
  LocationsController(this._localizationsRepository) : super(InitialState());

  Future<void> call(String companyId) async {
    update(LoadingState());
    final result = await _localizationsRepository.call(companyId);
    result.when(
      (right) => update(SuccessState(data: right)),
      (left) => update(ErrorState(exception: left)),
    );
  }
}
