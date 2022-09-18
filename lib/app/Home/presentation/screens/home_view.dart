import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Home/presentation/components/static_widgets.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/Home/presentation/components/main_page.dart';
import 'package:carpooling_beta/app/Home/presentation/components/my_rides_page.dart';
import 'package:carpooling_beta/app/Home/presentation/components/my_checkings_page.dart';
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
                  child: controller.myConversations.isEmpty
                      ? Center(
                          child: TextButton(
                              onPressed: () {
                                Get.toNamed('/chat', arguments: {
                                  'userTarget':
                                      'cc4b6ecc-0523-49a7-a4de-18c8cff17541',
                                });
                              },
                              child: Text('You have no conversations yet..')),
                        )
                      : ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          itemCount: controller.myConversations.length,
                          itemBuilder: (BuildContext buildContext, index) {
                            print('CONVERSATION:');
                            Message conversation =
                                controller.myConversations[index];
                            return GestureDetector(
                                onTap: () {
                                  Get.toNamed('/chat', arguments: {
                                    'userTarget':
                                        'cc4b6ecc-0523-49a7-a4de-18c8cff17541',
                                  });
                                },
                                child: Text(
                                    'myConversations with ${conversation.username}'));
                          }),
                ),
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
