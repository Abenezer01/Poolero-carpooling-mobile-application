import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/data/models/car_model.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/Profile/domain/usecases/car_usecase.dart';
import 'package:carpooling_beta/app/Profile/presentation/controllers/profile_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarController extends GetxController {
  RxBool isLoading = false.obs;
  late final RxList categories = [].obs;
  late final RxList colors = [].obs;
  late final RxList marks = [].obs;
  late final RxList models = [].obs;

  late TextEditingController modelYearController;

  ProfileController profileController = Get.find<ProfileController>();
  Rx<Car> car = Car(
    id: '',
    category: CarProperty(id: '', name: ''),
    color: CarProperty(id: '', name: ''),
    model: CarProperty(id: '', name: ''),
    mark: CarProperty(id: '', name: ''),
    modelYear: '',
    userId: Get.arguments['userId'],
  ).obs;

  @override
  void onInit() async {
    modelYearController = TextEditingController();
    if (!Get.arguments['addCar']) {
      car.value = Get.arguments['car'];
      modelYearController.text = car.value.modelYear;
    }

    final carProperties = await serviceLocator<CarUseCase>().getCarProperties();
    carProperties.fold((l) {
      Get.snackbar('Error occurred', l.message);
    }, (r) {
      r.forEach((key, value) {
        switch (key) {
          case 'categories':
            categories.value = value;
            break;
          case 'colors':
            colors.value = value;
            break;
          case 'marks':
            marks.value = value;
            break;
          case 'models':
            models.value = value;
            break;
          default:
            break;
        }
      });
    });

    isLoading.value = false;
    super.onInit();
  }

  addCar(Car car) async {
    car.setModelYear = modelYearController.value.text;
    print(car.modelYear);

    final newCar = await serviceLocator<CarUseCase>().addCar(car);
    newCar.fold((l) {
      Get.snackbar('Error', l.message);
    }, (r) {
      profileController.carsList.add(CarModel(
        id: r.id,
        category: r.category,
        color: r.color,
        mark: r.mark,
        model: r.model,
        modelYear: r.modelYear,
        userId: r.userId,
      ));
      Get.snackbar('Sccess', 'Your Car was added successfully');
      Get.toNamed('/profile');
    });
  }

  updateCar(Car car) async {
    final updatedCar = await serviceLocator<CarUseCase>().updateCar(car);
    updatedCar.fold((l) {
      Get.snackbar('Error', l.message);
    }, (r) {
      ProfileController profileController = Get.find<ProfileController>();
      profileController.carsList.map((element) {
        if (element.id == r.id) {
          print('Element.id: ${element.id} || r.id:${r.id}');
          element = CarModel(
            id: element.id,
            category: r.category,
            color: r.color,
            mark: r.mark,
            model: r.model,
            modelYear: r.modelYear,
            userId: r.userId,
          );

          return;
        }
      });
      Get.snackbar('Success', 'Your Car has been updated successfully');
      Get.toNamed('/profile');
    });
  }

  deleteCar(String carId) async {
    final idDeleted = await serviceLocator<CarUseCase>().deleteCar(carId);
    idDeleted.fold((l) {
      Get.snackbar('Error', l.message);
    }, (r) {
      ProfileController profileController = Get.find<ProfileController>();
      profileController.carsList.removeWhere((element) => element.id == carId);
      Get.snackbar('Success', 'Your Car has been deleted successfully');
      Get.toNamed('/profile');
    });
  }

  void questionDialog(String carId) => Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.all(0),
        content: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Image.asset('assets/ask.png', height: 120),
                SizedBox(height: 20),
                Text(
                  'Question',
                  style: TextStyle(
                    color: AppTheme.naturalColor1,
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Are You Confirm?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.naturalColor4,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        isPrimary: false,
                        isDisabled: false,
                        isDecline: true,
                        textTitle: 'Cancel',
                        onPresse: () => Get.close(1),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: MyButton(
                        isPrimary: true,
                        isDisabled: false,
                        textTitle: 'Confirm',
                        onPresse: () => deleteCar(carId),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
