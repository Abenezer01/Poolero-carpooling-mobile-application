import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';

abstract class DataError extends DomainError {
  const DataError._({String message = ''}) : super(message: message);

  factory DataError.failedToConvert({String message = 'Failed To Convert'}) =>
      _FailedToConvert(message: message);
  factory DataError.missingParameters(
          {String message = 'Missing Parameters'}) =>
      _MissingParameters(message: message);
  factory DataError.failedToStore(
          {String message = 'Failed To Storing Your Data'}) =>
      _FailedToStore(message: message);
  factory DataError.failedToGet({String message = 'Failed To Get Your Data'}) =>
      _FailedToGet(message: message);
  factory DataError.failedToLogout({String message = 'Failed To Logout'}) =>
      _FailedToLogout(message: message);
}

class _FailedToConvert extends DataError {
  _FailedToConvert({String message = ''}) : super._(message: message);
}

class _MissingParameters extends DataError {
  _MissingParameters({String message = ''}) : super._(message: message);
}

class _FailedToStore extends DataError {
  _FailedToStore({String message = ''}) : super._(message: message);
}

class _FailedToGet extends DataError {
  _FailedToGet({String message = ''}) : super._(message: message);
}

class _FailedToLogout extends DataError {
  _FailedToLogout({String message = ''}) : super._(message: message);
}
