import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/error_handling/base_error.dart';

abstract class HttpError extends DomainError {
  const HttpError._({String message = ''}) : super(message: message);

  factory HttpError.badRequest({String message = 'Bad Request'}) =>
      _BadRequest(message: message);
  factory HttpError.unauthorized({String message = 'Unauthorized'}) =>
      _Unauthorized(message: message);
  factory HttpError.forbidden({String message = 'Forbidden'}) =>
      _Forbidden(message: message);
  factory HttpError.notFound({String message = 'Not Found'}) =>
      _NotFound(message: message);
  factory HttpError.invalidData({String message = 'Invalid Data'}) =>
      _InvalidData(message: message);
  factory HttpError.timeOut({String message = 'TimeOut'}) =>
      _TimeOut(message: message);
  factory HttpError.serverError({String message = 'Server Error'}) =>
      _ServerError(message: message);
}

class _BadRequest extends HttpError {
  _BadRequest({String message = 'Bad Request'}) : super._(message: message);
}

class _Unauthorized extends HttpError {
  _Unauthorized({String message = 'Unauthorized'}) : super._(message: message);
}

class _Forbidden extends HttpError {
  _Forbidden({String message = 'Forbidden'}) : super._(message: message);
}

class _NotFound extends HttpError {
  _NotFound({String message = 'Not Found'}) : super._(message: message);
}

class _InvalidData extends HttpError {
  _InvalidData({String message = 'Invalid Data'}) : super._(message: message);
}

class _TimeOut extends HttpError {
  _TimeOut({String message = 'TimeOut'}) : super._(message: message);
}

class _ServerError extends HttpError {
  _ServerError({String message = 'Server Error'}) : super._(message: message);
}

extension ConvertToBaseError on HttpError {
  /// Convert HttpError to BaseError equivalent
  DomainError convertError() {
    switch (runtimeType) {
      case _BadRequest:
        return InvalidDataError(message: message);
      case _Unauthorized:
        return UnauthorizedError(message: message);
      case _Forbidden:
        return UnauthorizedError(message: message);
      case _NotFound:
        return NotFoundError(message: message);
      case _InvalidData:
        return InvalidDataError(message: message);
      case _TimeOut:
        return TimeOutError(message: message);
      case _ServerError:
        return ApiError(message: message);
      default:
        return ApiError(message: message);
    }
  }
}
