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
        // floatingActionButton: SpeedDial(
        //   animatedIcon: AnimatedIcons.menu_close,
        //   gradient: PrimaryColorGradient,
        //   gradientBoxShape: BoxShape.circle,
        //   // backgroundColor: PrimaryColor2,
        //   // foregroundColor: PrimaryColor,
        //   overlayColor: Colors.black,
        //   overlayOpacity: .1,
        //   spacing: 12,
        //   elevation: 10,
        //   children: [
        //     SpeedDialChild(
        //       child: Icon(Icons.add_location_alt_outlined),
        //       label: 'Add a trip',
        //       foregroundColor: PrimaryColor,
        //       onTap: () => Get.toNamed('/rider'),
        //     ),
        //     SpeedDialChild(
        //       child: Icon(Icons.garage_rounded),
        //       label: 'My vehicles',
        //       foregroundColor: PrimaryColor,
        //       onTap: () => Get.toNamed('/profile'),
        //     ),
        //     SpeedDialChild(
        //       child: Icon(Icons.chat),
        //       label: 'Chat',
        //       foregroundColor: PrimaryColor,
        //       onTap: () {
        //         controller.advancedDrawerController.hideDrawer();
        //         controller.tabController.animateTo(3,
        //             duration: Duration(milliseconds: 700),
        //             curve: Curves.easeIn);
        //       },
        //     ),
        //     SpeedDialChild(
        //       child: Icon(Icons.location_history),
        //       label: 'My ride',
        //       foregroundColor: PrimaryColor,
        //     ),
        //   ],
        // ),

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
        body: Builder(
          builder: (context) {
            return Obx(() {
              switch (controller.pageId.value) {
                case 'Home':
                  return Container(
                    margin: EdgeInsets.only(bottom: 50),
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
                      child: Center(
                          child: FloatingActionButton(
                        child: Text('Start Chating..'),
                        onPressed: () {
                          // controller.chating();
                        },
                      )),
                    ),
                  );
                default:
                  return Container();
              }
            });
          },
        ),
      ),
    );
  }
}
