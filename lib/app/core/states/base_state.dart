import '../errors/base_exception.dart';

abstract class BaseState {}

final class InitialState implements BaseState {}

final class LoadingState implements BaseState {}

final class SuccessState<R> implements BaseState {
  const SuccessState({
    required this.data,
  });

  final R data;
}

final class ErrorState<T extends BaseException> implements BaseState {
  const ErrorState({
    required this.exception, required ,
  });

  final T exception;
}
