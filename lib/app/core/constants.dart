import 'package:http/http.dart' as http;
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';

class AppConstants {
  static const String googleAPIKey = 'AIzaSyB5prNAYR4fcQ-FMDMVfOwskPAo6ZOk0II';
  static const String googleDirectionsBaseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
  static const String baseUrl = 'https://192.168.1.37:45455/api';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static const String loginPath = '$baseUrl/Account/authenticate';
  static const String registerPath = '$baseUrl/Account/register';
  static const String updateUserPath = '$baseUrl/Account/update';
  static const String getCarsPath = '$baseUrl/Car/GetAllCars';
  static const String getCategoriesPath = '$baseUrl/Category';
  static const String getColorsPath = '$baseUrl/Color';
  static const String getMarksPath = '$baseUrl/Mark';
  static const String getModelsPath = '$baseUrl/Model';
  static const String addUpdateCarPath = '$baseUrl/Car';
  static String deleteCarPath(String id) => '$baseUrl/Car/$id';
  static const String getRidesPath = '$baseUrl/Ride/GetAllRides';
  static const String getCheckingsPath = '$baseUrl/CheckIn/GetAllCheckIns';
  static const String addRidePath = '$baseUrl/Ride';

  static dynamic httpResponseHandler(http.Response response) {
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return response.body;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest();
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized();
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden();
    } else if (response.statusCode == 404) {
      throw HttpError.notFound();
    } else if (response.statusCode == 422) {
      throw HttpError.invalidData();
    } else {
      throw HttpError.serverError();
    }
  }
}
