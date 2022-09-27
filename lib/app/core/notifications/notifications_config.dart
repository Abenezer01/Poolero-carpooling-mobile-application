import 'package:carpooling_beta/app/core/Notification.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/notifications/notificationService.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> messageHandler(
    RemoteMessage message, AndroidNotificationChannel channel) async {
  print('Notif-title-back: ${message.notification!.title}');
  NotificationModel notificationMessage =
      NotificationModel.fromJson(message.data);

  // RemoteNotification notification = message.notification!;
  AndroidNotification? android = message.notification?.android;
  NotificationModel notificationMessageBackGround =
      NotificationModel.fromJson(message.data);

  NotificationService().showNotification(notificationMessageBackGround);
}

void firebaseMessagingListener(AndroidNotificationChannel channel) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // RemoteNotification notification = message.notification!;
    AndroidNotification? android = message.notification?.android;
    print('Notif-title: ${message.data["title"]}');
    NotificationModel notificationMessage =
        NotificationModel.fromJson(message.data);

    NotificationService().showNotification(notificationMessage);
    // print('notificationMessage: ' + message.notification!.title!);

    // if (notification != null && android != null) {
    //   FlutterLocalNotificationsPlugin().show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           channelDescription: channel.description,
    //           color: Colors.blue,
    //           // TODO add a proper drawable resource to android, for now using
    //           //      one that already exists in example app.
    //           icon: "@mipmap/ic_launcher",
    //         ),
    //       ));
    // }
  });
}

Future<void> sendNotification() async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  Dio dio = Dio();

  var token = await getDeviceToken();
  print('device token : $token');

  final data = {
    "data": {
      "message": "Accept Ride Request",
      "title": "This is Ride Request",
    },
    "to": token
  };

  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
      'key=${AppConstants.cloudMessagingServrKey}';

  try {
    final response = await dio.post(postUrl, data: data);

    if (response.statusCode == 200) {
      print('Request Sent To Driver');
    } else {
      print('notification sending failed');
    }
  } catch (e) {
    print('exception $e');
  }
}

Future<String?> getDeviceToken() async {
  return await FirebaseMessaging.instance.getToken();
}
