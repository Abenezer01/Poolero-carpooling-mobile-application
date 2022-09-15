import 'package:carpooling_beta/app/Profile/domain/usecases/profile_usecase.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxList carsList = [].obs;
  late User user;
  late RxString username = ''.obs;
  late RxString userId = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    getProfileInfos();
    isLoading.value = false;
  }

  Future<void> getProfileInfos() async {
    final profile = await ProfileUseCase(serviceLocator())();

    profile.fold((l) {
      print(l.message);
    }, (r) {
      user = r.user;
      username.value = r.user.username;
      userId.value = r.user.id;
      carsList.clear();
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
