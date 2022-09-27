import 'dart:ui';

import 'package:carpooling_beta/app/core/Notification.dart';
import 'package:carpooling_beta/app/core/notifications/notifications_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificationService {
  final localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  late AndroidNotificationChannel channel;
  // late final NotificationService notificationService;

  NotificationService() {
    channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    FirebaseMessaging.onBackgroundMessage(
        ((message) async => await messageHandler(message, channel)));

    // listenToNotificationStream();
    initializePlatformNotifications();
  }

  void listenToNotificationStream() => behaviorSubject.listen((payload) {
        print('User clicked on the notification');
      });

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         requestSoundPermission: true,
    //         requestBadgePermission: true,
    //         requestAlertPermission: true,
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    await localNotifications.initialize(initializationSettings);
  }

  showNotification(NotificationModel notification) async {
    await showLocalNotification(
      id: notification.hashCode,
      title: notification.title!,
      body: notification.body!,
      payload: "",
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void selectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      behaviorSubject.add(payload);
    }
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      icon: 'logo',
      largeIcon: const DrawableResourceAndroidBitmap('logo'),
      color: Color(0xff2196f3),
    );

    // IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
    //     threadIdentifier: "thread1",
    //     attachments: <IOSNotificationAttachment>[
    //       IOSNotificationAttachment(bigPicture)
    //     ]);

    // final details = await localNotifications.getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {
    //   behaviorSubject.add(details.notificationResponse!.payload!);
    // }
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }
}
