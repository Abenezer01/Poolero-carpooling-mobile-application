import 'package:get/get.dart';
import 'package:carpooling_beta/app/Profile/presentation/controllers/car_controller.dart';

class CarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarController>(
      () => CarController(),
    );
  }
}
