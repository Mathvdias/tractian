import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/components/interactor/interactor.dart';

final class ComponentsController extends BaseController<BaseState> {
  final IComponentsRepository _componentsRepository;
  ComponentsController(this._componentsRepository) : super(InitialState());

  Future<void> call(String companyId) async {
    update(LoadingState());
    final result = await _componentsRepository.call(companyId);
    result.when(
      (right) => update(SuccessState(data: right)),
      (left) => update(ErrorState(exception: left)),
    );
  }
}
