import 'package:http/http.dart' as http;
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:intl/intl.dart';

class AppConstants {
  static bool isAuth = true;

  static const String googleAPIKey = 'AIzaSyB5prNAYR4fcQ-FMDMVfOwskPAo6ZOk0II';
  static const String stripeAPIKey =
      'pk_test_51LiINJCMHlLurkUjeocsPwq1EzRMUxQtSuOOIM2KVKgIrs4j354mv4zM4ntBwGjvGiW6gf6n4BxlT0OrE2o64WUM00Yp923Hvs';
  static const String cloudMessagingServrKey =
      "AAAAk1s6hgI:APA91bGtf3aM6tog6YYnfTr4y6RBNPu2DKEJuoOSrjseFoACPItLh_CMqnyoHraS7HRthjrBEunMARfr2EeOIOyl56av7da7NMs-REDmlVDgzIBA3pBNG-FDGWif1ybcGhfh4-9W_8pM";
  static const String googleDirectionsBaseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
  static const String baseUrl = 'https://greatmintgrape42.conveyor.cloud/api';

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
  static String deleteCheckingPath(String id) => '$baseUrl/CheckIn/$id';
  static const String addCheckingPath = '$baseUrl/CheckIn';

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

  static DateTime fromTime(datetime) => DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(datetime);
}
