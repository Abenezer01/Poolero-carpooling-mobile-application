

import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/trip_card.dart';
import 'package:carpooling_beta/app/core/components/trip_infos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            TripCard(
              avatarImg: 'assets/Avatar.png',
              fullName: 'Bernard Alvarado',
              description:
                  'Marathalli, Bengaluru, Karnataka, India, Madiwata, Hosur Road, Silk board,…',
              tripInfos: [
                TripInfo(
                    icon: 'assets/Clock.png', info: '16:30', label: 'Time'),
                TripInfo(icon: 'assets/Chat.png', info: '94%', label: 'Ontime'),
                TripInfo(icon: 'assets/Money.png', info: '56', label: 'Points'),
              ],
              buttons: [
                MyButton(
                  isPrimary: false,
                  isDisabled: false,
                  textTitle: 'Route',
                  onPresse: () => Get.toNamed('/rider'),
                ),
                MyButton(
                  isPrimary: false,
                  isDisabled: false,
                  isDecline: true,
                  textTitle: 'Decline',
                  onPresse: () {},
                ),
                MyButton(
                  isPrimary: true,
                  isDisabled: false,
                  textTitle: 'Request',
                  onPresse: () {},
                ),
              ],
            ),
            TripCard(
              avatarImg: 'assets/Avatar.png',
              fullName: 'Bernard Alvarado',
              description:
                  'Marathalli, Bengaluru, Karnataka, India, Madiwata, Hosur Road, Silk board,…',
              tripInfos: [
                TripInfo(
                    icon: 'assets/Clock.png', info: '16:30', label: 'Time'),
                TripInfo(
                    icon: 'assets/Clock1.png', info: '17:35', label: 'Drop'),
                TripInfo(icon: 'assets/Money.png', info: '56', label: 'Points'),
              ],
              buttons: [
                MyButton(
                  isPrimary: false,
                  isDisabled: false,
                  textTitle: 'Route',
                  onPresse: () {},
                ),
                MyButton(
                  isPrimary: true,
                  isDisabled: false,
                  textTitle: 'Request',
                  onPresse: () {},
                ),
              ],
            ),
            TripCard(
              avatarImg: 'assets/Avatar.png',
              fullName: 'Bernard Alvarado',
              description:
                  'Marathalli, Bengaluru, Karnataka, India, Madiwata, Hosur Road, Silk board,…',
              tripInfos: [
                TripInfo(
                    icon: 'assets/Clock.png', info: '16:30', label: 'Time'),
                TripInfo(icon: 'assets/Chat.png', info: '94%', label: 'Ontime'),
                TripInfo(icon: 'assets/Money.png', info: '56', label: 'Points'),
              ],
              buttons: [
                MyButton(
                  isPrimary: false,
                  isDisabled: false,
                  isDecline: true,
                  textTitle: 'Decline',
                  onPresse: () {},
                ),
                MyButton(
                  isPrimary: true,
                  isDisabled: false,
                  textTitle: 'Accept',
                  onPresse: () {},
                ),
              ],
            ),
            TripCard(
              avatarImg: 'assets/Avatar.png',
              fullName: 'Bernard Alvarado',
              description:
                  'Marathalli, Bengaluru, Karnataka, India, Madiwata, Hosur Road, Silk board,…',
              tripInfos: [
                TripInfo(
                    icon: 'assets/Clock.png', info: '16:30', label: 'Time'),
                TripInfo(
                    icon: 'assets/Clock1.png', info: '17:35', label: 'Drop'),
                TripInfo(icon: 'assets/Money.png', info: '56', label: 'Points'),
              ],
              buttons: [
                MyButton(
                  isPrimary: false,
                  isDisabled: false,
                  textTitle: 'Route',
                  onPresse: () {},
                ),
                MyButton(
                  isPrimary: true,
                  isDisabled: false,
                  textTitle: 'Request',
                  onPresse: () {},
                ),
              ],
            ),
            TripCard(
              avatarImg: 'assets/Avatar.png',
              fullName: 'Bernard Alvarado',
              description:
                  'Marathalli, Bengaluru, Karnataka, India, Madiwata, Hosur Road, Silk board,…',
              tripInfos: [
                TripInfo(
                    icon: 'assets/Clock.png', info: '16:30', label: 'Time'),
                TripInfo(icon: 'assets/Chat.png', info: '94%', label: 'Ontime'),
                TripInfo(icon: 'assets/Money.png', info: '56', label: 'Points'),
              ],
              buttons: [
                MyButton(
                  isPrimary: false,
                  isDisabled: false,
                  isDecline: true,
                  textTitle: 'Decline',
                  onPresse: () {},
                ),
                MyButton(
                  isPrimary: true,
                  isDisabled: false,
                  textTitle: 'Accept',
                  onPresse: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
