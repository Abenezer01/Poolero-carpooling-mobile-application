import 'package:carpooling_beta/app/Profile/domain/usecases/profile_usecase.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxList carsList = [].obs;
  late RxString username = ''.obs;
  late RxString userId = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = false;
    final profile = await ProfileUseCase(serviceLocator())();

    profile.fold((l) {
      print(l.message);
    }, (r) {
      username.value = r.user.username;
      userId.value = r.user.id;
      carsList.addAll(r.carsList!);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
