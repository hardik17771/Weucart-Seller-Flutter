import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

class FCMNotificationController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User grant Permissions");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User grant provisional Permissions");
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      debugPrint("User declinde Permissions");
    }
  }

  // getting device token for firebase notification
  Future<String> getDeviceToken() async {
    String? deviceToken = await _firebaseMessaging.getToken();
    return deviceToken!;
  }

  // used when token is regeneratedand we want to upgrade this token in server
  void isTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      debugPrint(event.toString());
    });
  }

  // ---- Get Notifications ----------------------------------------------->

  // ForeGround Messaging
  void initializeFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(message.notification!.title!);
      debugPrint(message.notification!.body!);
      debugPrint(message.data.toString());

      if (Platform.isAndroid) {
        initializeFlutterLocalNotifications(context, message);
        showNotification(message);
      }
      if (Platform.isIOS) {
        // IOS Notifications Method
        showNotification(message);
      }
    });
  }

  Future<void> setUpInteractMessage(BuildContext context) async {
    // App -> Terminated Messages Navigation
    RemoteMessage? terMessage = await _firebaseMessaging.getInitialMessage();
    if (terMessage != null) {
      // ignore: use_build_context_synchronously
      handleMessageNavigation(context, terMessage);
    }

    // App -> Background Messages Navigation
    FirebaseMessaging.onMessageOpenedApp.listen((bgMessage) {
      handleMessageNavigation(context, bgMessage);
    });
  }

  void handleMessageNavigation(BuildContext context, RemoteMessage message) {
    // if (message.data['type'] == 'orderMessage') {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) {
    //         // later to be changed to OrderDetailsPage(id : message.data['orderId']);
    //         return const MyOrdersPage();
    //       },
    //     ),
    //   );
    // }
  }

  void initializeFlutterLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      iOS: iosInitializationSettings,
      android: androidInitializationSettings,
    );

    // App -> foreground Messages navigation
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMessageNavigation(context, message);
    });
  }

  void showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      const Uuid().v1(),
      'High Importance Channel',
      importance: Importance.high,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      androidNotificationChannel.id,
      androidNotificationChannel.name,
      channelDescription: "Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title!.toString(),
        message.notification!.body!.toString(),
        notificationDetails,
      );
    });
  }

  // ---- Post Notifications ----------------------------------------------->

  // Future<void> sendOrderNotification({
  //   required String orderStatus,
  //   required OrderModel orderModel,
  //   required VendorModel vendorModel,
  //   required UserModel userModel,
  // }) async {
  //   var data = {
  //     'to': vendorModel.vendorDeviceToken,
  //     // 'priority': 'high',
  //     'notification': {
  //       'title': userModel.username,
  //       'body': orderStatus,
  //       "sound": "jetsons_doorbell.mp3"
  //     },
  //     'android': {
  //       'notification': {
  //         'notification_count': 0,
  //       },
  //     },
  //     'data': {
  //       'type': 'orderMessage',
  //       'id': orderModel.orderId,
  //     }
  //   };

  //   await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization':
  //           'key=AAAAsUa9sVI:APA91bHom0F6bwnx4GO4f62S3fD-XJ6ZhRUlfVtGh4mtyeoFS6sUZxq3RJtuoUMnUcMCFTEE9RRQW5t0QriNxpW1u3Y_Fhsd33DV80tUi8yUwwX0glkTwogkq8CAWel0yzqZweLVSBS-',
  //     },
  //   ).then((value) {
  //     debugPrint(value.body.toString());
  //   }).onError((error, stackTrace) {
  //     debugPrint(error.toString());
  //   });
  // }
}
