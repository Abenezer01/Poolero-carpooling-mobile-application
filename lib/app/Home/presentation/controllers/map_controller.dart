import 'package:carpooling_beta/app/Home/domain/entities/Passager.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/add_checkings_usecase.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/payment_controller.dart';
import 'package:carpooling_beta/app/Profile/presentation/controllers/profile_controller.dart';
import 'package:carpooling_beta/app/core/error_handling/validation_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Place.dart';
import 'package:carpooling_beta/app/Home/domain/entities/directions.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/add_ride_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/find_ride_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/Home/presentation/screens/find_ride_view.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:carpooling_beta/app/core/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';

class MapController extends GetxController {
  RxBool isLoading = false.obs;
  CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(35.7635389, -5.8248361), zoom: 14);
  static GoogleMapController? googleMapController;
  late Rx<Marker>? origin, destination, currentLocationMarker;
  Rx<Directions>? directions;
  late Map fromPosition, toPosition;
  RxBool focusOnMap = false.obs;
  RxBool exploreRide = false.obs;
  RxBool switchForm = false.obs;
  late Rx<TextEditingController> originTextController,
      destinationTextController,
      timePicker1Controller,
      timePicker2Controller,
      choosedCarController,
      totalCostController,
      numFreeSpotsController,
      requestedSeatsController;
  late RxBool allowPauses, allowBigBags, allowSmocking;
  late RxString choosedCar;
  RxList carsList = [].obs;
  RxList ridesList = [].obs;
  String? startTime, endTime;
  User? user;
  late final homeController;
  late GlobalKey<FormState> formKey;

  @override
  void onInit() async {
    super.onInit();

    origin = Marker(markerId: MarkerId('origin')).obs;
    destination = Marker(markerId: MarkerId('destination')).obs;
    directions = Directions().obs;

    originTextController = TextEditingController().obs;
    destinationTextController = TextEditingController().obs;
    timePicker1Controller = TextEditingController().obs;
    timePicker2Controller = TextEditingController().obs;
    choosedCarController = TextEditingController().obs;
    totalCostController = TextEditingController().obs;
    numFreeSpotsController = TextEditingController().obs;
    requestedSeatsController = TextEditingController().obs;
    allowPauses = false.obs;
    allowBigBags = false.obs;
    allowSmocking = false.obs;
    choosedCar = ''.obs;

    print("isAuth: ${AppConstants.isAuth}");
    if (AppConstants.isAuth) {
      homeController = Get.find<HomeController>();
      user = homeController.user;
      carsList.value = homeController.profile.carsList;
    } else {
      switchForm.value = true;
    }

    if (Get.arguments != null) {
      if (Get.arguments['route']) {
        RouteRide(Get.arguments['fromPlace'], Get.arguments['toPlace']);
      }
    }
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    originTextController.value.dispose();
    destinationTextController.value.dispose();
    timePicker1Controller.value.dispose();
    timePicker2Controller.value.dispose();
    choosedCarController.value.dispose();
    totalCostController.value.dispose();
    numFreeSpotsController.value.dispose();
    requestedSeatsController.value.dispose();
    allowPauses = false.obs;
    allowBigBags = false.obs;
    allowSmocking = false.obs;
    choosedCar = ''.obs;

    origin = Marker(markerId: MarkerId('origin')).obs;
    destination = Marker(markerId: MarkerId('destination')).obs;
    directions = Directions().obs;
    isLoading.value = true;

    super.onClose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      addRide();
    }
  }

  String? textFieldValidation(value, String field) {
    try {
      if (GetUtils.isNull(value) || GetUtils.isLengthEqualTo(value, 0)) {
        throw ValidationError.requiredField(
            message: 'The $field field is required!');
      }
      return null;
    } on ValidationError catch (e) {
      return e.message;
    }
  }

  String? pickTimeValidation(value) {
    try {
      if (GetUtils.isNull(value) || GetUtils.isLengthEqualTo(value, 0)) {
        throw ValidationError.requiredField(
            message: 'The Pick Time field is required!');
      }
      return null;
    } on ValidationError catch (e) {
      return e.message;
    }
  }

  Future<void> showSearchBar(context, type) async {
    Prediction? p;
    try {
      p = await PlacesAutocomplete.show(
        logo: SizedBox(),
        context: context,
        apiKey: AppConstants.googleAPIKey,
        mode: Mode.fullscreen,
        language: "fr",
        offset: 0,
        hint: 'Search',
        onError: (PlacesAutocompleteResponse response) {
          print('Error:');
          print(response.errorMessage ?? 'Unknown error');
        },
        // decoration: InputDecoration(
        //   hintText: 'Search',
        // ),
        radius: 1000,
        types: [],
        strictbounds: false,
        components: [Component(Component.country, "ma")],
      );
    } catch (e) {
      print(e);
    }
    print('Prediction:');
    print(p!.description.toString());

    PlacesDetailsResponse location = await _geoLocationFromPlaceId(p!.placeId);
    var document = parse(location.result.adrAddress!);
    String city = document.querySelector('.locality')!.text;
    // String street = document.querySelector('.street-address')!.text;
    // String countryName = document.querySelector('.postal-code')!.text;
    // String country = document.querySelector('.country-name')!.text;

    String address =
        '${location.result.name}, ${location.result.formattedAddress!}';
    LatLng pos = LatLng(location.result.geometry!.location.lat,
        location.result.geometry!.location.lng);
    if (type == 'origin') {
      await googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: pos, zoom: 16, tilt: 50.0)));
      fromPosition = {
        'city': city,
        'adresse': address,
        'latitude': pos.latitude,
        'longitude': pos.longitude,
      };
      originTextController.value.text = address;
      origin!.value = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          position: pos);
    } else {
      await googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: pos, zoom: 16, tilt: 50.0)));
      toPosition = {
        'city': city,
        'adresse': address,
        'latitude': pos.latitude,
        'longitude': pos.longitude,
      };
      destinationTextController.value.text = address;
      destination!.value = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'destination'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos);
    }
    drawPoylines();
  }

  void drawPoylines() async {
    directions!.value = (await getDirections(
        origin: origin!.value.position,
        destination: destination!.value.position))!;

    await updateMapToBounds(
        getCurrentBounds(origin!.value.position, destination!.value.position));
  }

  Future<Directions?> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    final response =
        await Dio().get(AppConstants.googleDirectionsBaseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': AppConstants.googleAPIKey,
    });

    // Check if response is successful
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Directions.fromMap(response.data);
    }
    return null;
  }

  Future<PlacesDetailsResponse> _geoLocationFromPlaceId(String? placeId) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: AppConstants.googleAPIKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    return await _places.getDetailsByPlaceId(placeId!);
  }

  void pickDatTime(context, numbre) async {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    DateTime? datePicked;
    TimeOfDay? timePicked;
    datePicked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (datePicked != null) {
      timePicked = await showTimePicker(
        context: context,
        builder: (context, childWidget) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: childWidget!),
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );
    }
    print('DateTime Picked:');
    print(context);
    final date = DateFormat('yyyy-MM-dd').format(datePicked!);
    final time =
        '${timePicked!.hour < 10 ? '0' : ''}${timePicked.hour}:${timePicked.minute < 10 ? '0' : ''}${timePicked.minute}';
    print(dateFormat.format(DateTime.parse('$date $time')));
    (numbre == 1 ? timePicker1Controller : timePicker2Controller).value.text =
        dateFormat.format(DateTime.parse('$date $time'));
    numbre == 1
        ? startTime = '${DateTime.parse('$date $time').toIso8601String()}Z'
        : endTime = '${DateTime.parse('$date $time').toIso8601String()}Z';
  }

  LatLngBounds getCurrentBounds(LatLng position1, LatLng position2) {
    LatLngBounds bounds;

    try {
      bounds = LatLngBounds(
        northeast: position1,
        southwest: position2,
      );
    } catch (e) {
      bounds = LatLngBounds(
        northeast: position2,
        southwest: position1,
      );
    }

    return bounds;
  }

  Future updateMapToBounds(LatLngBounds bounds) async {
    await Future.delayed(Duration(milliseconds: 100), () {
      googleMapController?.animateCamera(CameraUpdate.newLatLngBounds(
          MapUtils.boundsFromLatLngList([origin!.value, destination!.value]
              .map((loc) => loc.position)
              .toList()),
          40));
    });
  }

  void addRide() async {
    final newRide = Ride(
      id: '',
      departureDate: startTime!,
      endTime: endTime!,
      totalCost: double.parse(totalCostController.value.text),
      totalDistance: 1.1,
      numFreeSpots: int.parse(numFreeSpotsController.value.text),
      availableSeats: int.parse(numFreeSpotsController.value.text),
      fromPlace: Place(
        city: fromPosition['city'],
        adresse: fromPosition['adresse'],
        latitude: fromPosition['latitude'],
        longitude: fromPosition['longitude'],
      ),
      toPlace: Place(
        city: toPosition['city'],
        adresse: toPosition['adresse'],
        latitude: toPosition['latitude'],
        longitude: toPosition['longitude'],
      ),
      car: choosedCar.value,
      driver: user!.id,
      status: Status.Planned.index,
      allowPauses: allowPauses.value,
      allowBigBags: allowBigBags.value,
      allowSmoking: allowSmocking.value,
    );

    final ride = await AddRideUseCase(serviceLocator())(newRide);
    ride.fold((l) {
      Get.snackbar('Error occurred', l.message,
          backgroundColor: AppTheme.accentColor, colorText: Colors.white);
    }, (r) {
      homeController.myRides.add(r);
      homeController.myRides.refresh();
      print(homeController.myRides);
      Get.snackbar(
        'New Ride',
        'Your ride was added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
      homeController.pageId.value = 'My rides';
      homeController.update();
      Get.toNamed('/home');
    });
    isLoading.value = false;
  }

  void findRide() async {
    final fromCity = fromPosition['city'];
    final toCity = toPosition['city'];
    final departureDate = startTime;
    final resultsRidesList = await FindRideUseCase(serviceLocator())(
        fromCity,
        toCity,
        departureDate,
        int.parse(requestedSeatsController.value.text),
        null);
    resultsRidesList.fold((l) {
      Get.snackbar('Error occurred', l.message,
          backgroundColor: AppTheme.accentColor, colorText: Colors.white);
    }, (r) {
      ridesList.clear();
      ridesList.addAll(r);
      Get.to(
        FindRideView(),
        popGesture: true,
      );
    });
    isLoading.value = false;
  }

  void pay(int seats, double price, Ride ride) async {
    int amount = (seats * price).round();
    print('AMOUNT: $amount');
    PaymentController payController = PaymentController();
    try {
      await payController
          .makePayment(amount: amount.toString(), currency: 'MAD')
          .then((value) {
        if (value) CheckInRide(seats, ride);
      });
    } catch (e) {
      Get.snackbar(
        'Payment',
        'Payment Canceled',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void CheckInRide(int requestedSeats, Ride ride) async {
    final newChecking = await AddCheckingUseCase(serviceLocator())(
      ride,
      requestedSeats,
      Passager(
          id: user!.id,
          firstName: user!.firstName,
          lastName: user!.lastName,
          userName: user!.username,
          email: user!.email),
    );

    newChecking.fold((l) {
      Get.snackbar('Error occurred', l.message,
          backgroundColor: AppTheme.accentColor, colorText: Colors.white);
    }, (r) {
      final homeController = Get.find<HomeController>();
      homeController.myCheckings.add(r);
      homeController.myCheckings.refresh();
      homeController.pageId.value = 'Checkings';
      homeController.update();
      Get.toNamed('/home');
    });
  }

  void RouteRide(Place fromPlacePos, Place toPlacePos) {
    print('RouteRide');
    print(fromPlacePos);
    print(toPlacePos);

    origin!.value = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        position: LatLng(double.parse(fromPlacePos.latitude.toString()),
            double.parse(fromPlacePos.longitude.toString())));
    destination!.value = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(toPlacePos.latitude, toPlacePos.longitude));
    directions = Directions().obs;
    drawPoylines();
    focusOnMap.value = false;
    exploreRide.value = true;

    fromPosition = {
      'city': fromPlacePos.city,
      'adresse': fromPlacePos.adresse,
      'latitude': fromPlacePos.latitude,
      'longitude': fromPlacePos.longitude,
    };
    toPosition = {
      'city': toPlacePos.city,
      'adresse': toPlacePos.adresse,
      'latitude': toPlacePos.latitude,
      'longitude': toPlacePos.longitude,
    };

    // Get.toNamed('/map');
  }
}
