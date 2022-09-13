import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';

class ApiError extends DomainError {
  ApiError({String message = 'Api Error'}) : super(message: message);
}

class InvalidDataError extends DomainError {
  InvalidDataError({String message = 'Invalid Data Error'})
      : super(message: message);
}

class NoConnectionError extends DomainError {
  NoConnectionError({String message = 'No Connection Error'})
      : super(message: message);
}

class NotFoundError extends DomainError {
  NotFoundError({String message = 'Not Found Error'}) : super(message: message);
}

class TimeOutError extends DomainError {
  TimeOutError({String message = 'TimeOut Error'}) : super(message: message);
}

class UnauthorizedError extends DomainError {
  UnauthorizedError({String message = 'Unauthorized Error'})
      : super(message: message);
}
