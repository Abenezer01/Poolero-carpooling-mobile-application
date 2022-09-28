import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Checking.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/cancel_checking_usecase.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';
import 'package:carpooling_beta/app/Profile/presentation/controllers/profile_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/rides_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/checkings_usecase.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:carpooling_beta/app/core/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  final AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();
  late final User? user;
  RxString username = ''.obs;
  RxString token = ''.obs;
  RxString userId = ''.obs;
  late final TabController tabController =
      TabController(vsync: this, length: 4);
  RxString pageId = 'Home'.obs;
  late final RxList<Ride> ridesList = (List<Ride>.empty(growable: true)).obs;
  late final RxList<Ride> myRides = (List<Ride>.empty(growable: true)).obs;
  late final RxList<Checking> myCheckings =
      (List<Checking>.empty(growable: true)).obs;
  late final RxList<Message> myConversations =
      (List<Message>.empty(growable: true)).obs;
  RxString checkingId = ''.obs;
  late final ProfileController profile;

  @override
  void onInit() async {
    super.onInit();
    AppConstants.isAuth = true;
    profile = Get.put<ProfileController>(ProfileController());

    if (Get.arguments != null) {
      if (Get.arguments['googleAuth'] != null) {
        print("USER-ID: ${profile.user!.id}");
        setUserInfos(Get.arguments['user']);
        return;
      }
    }
    profile.getProfileInfos().then((value) async {
      print("USER-ID: ${profile.user!.id}");
      setUserInfos(profile.user!);
    });
  }

  setUserInfos(User userObj) async {
    print('SETTING USER INFO');
    user = userObj;
    username.value = user!.username;
    userId.value = user!.id;

    getCheckingList();
    getConversations(userId.value);

    ridesList.clear();
    ridesList.addAll(await getRidesList('Tangier', 'Tangier', null, 0, null));
    myRides.clear();
    myRides.addAll(await getRidesList(null, null, null, 0, userId.value));

    FirebaseFirestore.instance.collection('users').doc(user!.id).set({
      'userId': user!.id,
      'username': user!.username,
      'urlAvatar': user!.profileImg,
      'deviceToken': await FirebaseMessaging.instance.getToken(),
    });
  }

  @override
  void onReady() {
    super.onReady();
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<Ride>> getRidesList(String? fromPlace, String? toPlace,
      String? date, int requestedSeats, String? driverId) async {
    final rides = await GetRidesUseCase(serviceLocator())(
        fromPlace, toPlace, date, requestedSeats, driverId);
    return rides.fold((l) {
      Get.snackbar('Error occurred', l.message,
          backgroundColor: AppTheme.accentColor, colorText: Colors.white);
      return [];
    }, (r) {
      return r;
    });
  }

  void getCheckingList() async {
    final myCheckingsList =
        await CheckingsUseCase(serviceLocator())(userId.value);
    myCheckingsList.fold((l) {
      Get.snackbar('Error occurred', l.message);
    }, (r) {
      myCheckings.addAll(r);
    });
  }

  void getConversations(String userId) async {
    myConversations.clear();
    FirebaseFirestore.instance
        .collection('/chats/$userId/messages')
        .get()
        .then((mesages) {
      mesages.docs.map((doc) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(doc.get('toUser'))
            .get()
            .then((value) {
          myConversations.add(Message(
              idUser: doc.get('fromUser'),
              toUser: doc.get('toUser'),
              urlAvatar: value.get('urlAvatar'),
              username: value.get('username'),
              message: doc.get('message'),
              createdAt: ChatUtils.toDateTime(doc.get('createdAt'))));
          myConversations.refresh();
        });
      }).toList();
    });

    // myConversations.bindStream(converstions);
  }

  void questionDialog() => Get.defaultDialog(
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
                    fontFamily: AppTheme.primaryFont,
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
                    fontFamily: AppTheme.primaryFont,
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
                          onPresse: () {
                            cancelChecking();
                            Get.close(1);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  void cancelChecking() async {
    final deletedChecking =
        await CancelChechingUseCase(serviceLocator())(checkingId.value);
    deletedChecking.fold((l) {
      Get.snackbar('Error occurred', l.message);
    }, (r) {
      if (r) {
        myCheckings.removeWhere((element) => element.id == checkingId.value);

        Get.snackbar(
          'Checking',
          'Your Checking was successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
      }
    });
  }
}
