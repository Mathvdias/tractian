import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/modules.dart';

final class HomeController extends BaseController<BaseState> {
  final IHomeRepository _homeRepository;
  HomeController(this._homeRepository) : super(InitialState());

  Future<void> getCompanies() async {
    update(LoadingState());
    final result = await _homeRepository.call();
    result.when(
      (right) => update(SuccessState(data: right)),
      (left) => update(ErrorState(exception: left)),
    );
  }
}
