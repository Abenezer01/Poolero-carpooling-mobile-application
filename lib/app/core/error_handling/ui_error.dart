import 'package:carpooling_beta/app/core/error_handling/base_error.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';

abstract class UIError extends DomainError {
  const UIError._({String message = ''}) : super(message: message);

  factory UIError.apiError({String message = ''}) => _ApiError(message: message);
}

class _ApiError extends UIError {
  const _ApiError({String message = ''}) : super._(message: message);
}

extension ConverToUIError on DomainError {
  UIError toUIError() {
    switch (runtimeType) {
      case ApiError:
        return UIError.apiError(message: 'Error no servidor');
      default:
        return UIError.apiError(message: message);
    }
  }
}