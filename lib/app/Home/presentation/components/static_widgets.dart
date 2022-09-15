import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandabar/model.dart';
import 'package:pandabar/main.view.dart';

class MyDrawer extends GetWidget<HomeController> {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed('/profile'),
                child: Container(
                  width: 110.0,
                  height: 110.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/userImg.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => Get.toNamed('/profile'),
                child: Obx(
                  () => Text(
                    controller.username.value,
                    style: TextStyle(
                      color: AppTheme.naturalColor5,
                      fontFamily: AppTheme.primaryFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        controller.advancedDrawerController.hideDrawer();
                        controller.tabController.animateTo(0,
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeIn);
                      },
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    ListTile(
                      onTap: () {
                        controller.advancedDrawerController.hideDrawer();
                        controller.tabController.animateTo(0,
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeIn);
                      },
                      leading: Icon(Icons.account_circle_rounded),
                      title: Text('My Ride'),
                    ),
                    ListTile(
                      onTap: () {
                        controller.advancedDrawerController.hideDrawer();
                        controller.tabController.animateTo(2,
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeIn);
                      },
                      leading: Icon(Icons.favorite),
                      title: Text('Favourites'),
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed('/profile');
                      },
                      leading: Icon(Icons.car_repair),
                      title: Text('My vehicles'),
                    ),
                    ListTile(
                      onTap: () {
                        controller.advancedDrawerController.hideDrawer();
                        controller.tabController.animateTo(3,
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeIn);
                      },
                      leading: Icon(Icons.chat_outlined),
                      title: Text('My chat'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                    ListTile(
                      onTap: () async {
                        // await FlutterSecureStorage().delete(key: 'id');
                        Get.toNamed('/login');
                      },
                      leading: Icon(Icons.logout_outlined),
                      title: Text('Logout'),
                    ),
                  ],
                ),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('All rights are reserved to us ;)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyActions extends GetWidget<HomeController> {
  const MyActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => controller.advancedDrawerController.showDrawer(),
            child: Icon(Icons.menu_rounded,
                color: AppTheme.primaryColor, size: 25),
          ),
          Text(
            'Your next ride',
            style: TextStyle(
              color: AppTheme.naturalColor1,
              fontFamily: AppTheme.primaryFont,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/profile'),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor2,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Image.asset('assets/userImg.png'),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBar extends GetWidget<HomeController> {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PandaBar(
      buttonData: [
        PandaBarButtonData(id: 'Home', icon: Icons.home_rounded, title: 'Home'),
        PandaBarButtonData(
            id: 'My rides', icon: Icons.car_rental, title: 'My rides'),
        PandaBarButtonData(
            id: 'Checkings', icon: Icons.checklist_rounded, title: 'Checkings'),
        PandaBarButtonData(
            id: 'Contacts', icon: Icons.contacts_rounded, title: 'Contacts'),
      ],
      backgroundColor: Colors.white,
      buttonSelectedColor: AppTheme.primaryColor,
      fabColors: [
        AppTheme.fromHex('#756AED'),
        AppTheme.fromHex('#A091F6'),
      ],
      onChange: (id) {
        controller.pageId.value = id;
      },
      onFabButtonPressed: () {
        Get.toNamed('/map');
      },
    );
  }
}

class TripInfo extends StatelessWidget {
  final String icon;
  final String info;
  final String label;

  const TripInfo(
      {Key? key, required this.icon, required this.info, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [Image.asset(icon)],
            ),
            SizedBox(width: 7),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info,
                  style: TextStyle(
                    color: AppTheme.naturalColor1,
                    fontFamily: AppTheme.primaryFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.naturalColor4,
                    fontFamily: AppTheme.primaryFont,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class TripCard extends StatelessWidget {
  final String avatarImg;
  final String fullName;
  final double rating;
  final int nbrFeedbacks;
  final String description;
  final Widget? body;
  final List<TripInfo>? tripInfos;
  final List<MyButton>? buttons;

  TripCard({
    Key? key,
    required this.avatarImg,
    required this.fullName,
    this.rating = 0.0,
    this.nbrFeedbacks = 0,
    this.description = '',
    this.body,
    this.tripInfos,
    this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      width: size.width * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        boxShadow: [AppTheme.roundItemShadowColor],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(avatarImg),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName,
                              style: TextStyle(
                                fontFamily: AppTheme.primaryFont,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.naturalColor1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Image.asset('assets/king.png'),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              size: 20.0,
                              color: AppTheme.semanticColor2,
                            ),
                            SizedBox(width: 5),
                            Text(
                              rating.toString(),
                              style: TextStyle(
                                color: AppTheme.naturalColor1,
                                fontFamily: AppTheme.primaryFont,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '(${nbrFeedbacks.toString()})',
                              style: TextStyle(
                                color: AppTheme.naturalColor4,
                                fontFamily: AppTheme.primaryFont,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.drive_eta,
                              size: 18,
                              color: AppTheme.naturalColor4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (description.isNotEmpty)
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppTheme.naturalColor1,
                      fontFamily: AppTheme.primaryFont,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 5),
            if (body != null)
              Container(
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: body),
              ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [for (TripInfo info in tripInfos ?? []) info],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (MyButton button in buttons ?? [])
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 40,
                      child: button,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class MyActionButton extends StatelessWidget {
  final String toolTiptext;
  final VoidCallback onPressedCall;
  final IconData icon;
  const MyActionButton({
    required this.toolTiptext,
    required this.onPressedCall,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: FloatingActionButton(
        heroTag: toolTiptext,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: onPressedCall,
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
