import 'package:get/get.dart';
import 'package:carpooling_beta/app/Auth/presentation/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}
