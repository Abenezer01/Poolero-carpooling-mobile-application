import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Home/presentation/components/static_widgets.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/Home/presentation/components/main_page.dart';
import 'package:carpooling_beta/app/Home/presentation/components/my_rides_page.dart';
import 'package:carpooling_beta/app/Home/presentation/components/my_checkings_page.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: controller.advancedDrawerController,
      backdropColor: AppTheme.primaryColor,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: MyDrawer(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          actions: [MyActions()],
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ]),
          child: BottomBar(),
        ),
        body: Obx(() {
          switch (controller.pageId.value) {
            case 'Home':
              return Container(
                child: SafeArea(
                  bottom: false,
                  child: MainPage(),
                ),
              );
            case 'My rides':
              return Container(
                margin: EdgeInsets.only(bottom: 50),
                child: SafeArea(
                  bottom: false,
                  child: MyRidesPage(),
                ),
              );
            case 'Checkings':
              return Container(
                margin: EdgeInsets.only(bottom: 50),
                child: SafeArea(
                  bottom: false,
                  child: MyCheckingsPage(),
                ),
              );
            case 'Contacts':
              return Container(
                margin: EdgeInsets.only(bottom: 50),
                child: SafeArea(
                    bottom: false,
                    child: Obx(
                      () => controller.myConversations.isEmpty
                          ? Center(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed('/chat', arguments: {
                                    'userTarget':
                                        "cc4b6ecc-0523-49a7-a4de-18c8cff17541",
                                  });
                                },
                                child: Text(
                                  'You have no conversations yet..',
                                  style: TextStyle(
                                    color: AppTheme.naturalColor1,
                                    fontFamily: AppTheme.primaryFont,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              itemCount: controller.myConversations.length,
                              itemBuilder: (BuildContext buildContext, index) {
                                Message conversation =
                                    controller.myConversations[index];
                                return GestureDetector(
                                  onTap: () {
                                    String userTarget;
                                    if (controller.userId.value !=
                                        conversation.idUser) {
                                      userTarget = conversation.idUser;
                                    } else {
                                      userTarget = conversation.toUser;
                                    }
                                    Get.toNamed('/chat', arguments: {
                                      'userTarget': userTarget,
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20.0),
                                    width: Get.width * .9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                      boxShadow: [
                                        AppTheme.roundItemShadowColor
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            conversation.urlAvatar,
                                            width: 60,
                                            height: 60,
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                conversation.username,
                                                style: TextStyle(
                                                  color: AppTheme.naturalColor1,
                                                  fontFamily:
                                                      AppTheme.primaryFont,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'message: ${conversation.message}',
                                                style: TextStyle(
                                                  color: AppTheme.naturalColor3,
                                                  fontFamily:
                                                      AppTheme.primaryFont,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          )),
                                          Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.send_rounded,
                                              color: AppTheme.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    )),
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
