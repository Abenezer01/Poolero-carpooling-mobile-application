import 'package:get/get.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(),
    );
  }
}
