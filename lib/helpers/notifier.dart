//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:snack_bar/screens/Home/root_app.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
//
// class Notifier{
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//
//   FlutterLocalNotificationsPlugin
//   flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future selectNotification(String? payload) async {
//     if (payload != null) {
//       print('notification payload: $payload');
//     } else {
//       print("Notification Done");
//     }
//     Get.to(()=>const RootApp());
//   }
//
//   Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//     Get.dialog(const Text('Welcome To Snackbar'));
//   }
//
//   Future<void> _configureLocalTimeZone() async{
//     tz.initializeTimeZones();
//     final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZone));
//   }
//
//   displayNotification({required String title, required String body}) async {
//     print("doing test");
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//         'your channel id', 'your channel name',
//         importance: Importance.max, priority: Priority.high);
//     // var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       // iOS: iOSPlatformChannelSpecifics
//     );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }
//
//   Future<void> initNotify() async{
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('Token: $fCMToken');
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//
//     _configureLocalTimeZone();
//     // final IOSInitializationSettings initializationSettingsIOS =
//     // IOSInitializationSettings(
//     //     requestSoundPermission: false,
//     //     requestBadgePermission: false,
//     //     requestAlertPermission: false,
//     //     onDidReceiveLocalNotification: onDidReceiveLocalNotification
//     // );
//
//     const  AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('appicon');
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       // iOS: initializationSettingsIOS,
//       android:initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onSelectNotification: selectNotification
//     );
//   }
// }
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async{
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }