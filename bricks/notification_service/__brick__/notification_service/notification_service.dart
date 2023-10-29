import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notification_service.dart';

class FCMNotificationService {
  static String fcmDeviceToken = '';
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initialize(AuthorizationStatus authorizationStatus) async {
    await getToken();
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    // final DarwinInitializationSettings initializationSettingsDarwin =
    //     DarwinInitializationSettings(
    //         onDidReceiveLocalNotification: (s, r, t, a) =>
    //             onDidReceiveLocalNotification);
    // final InitializationSettings initializationSettings =
    //     InitializationSettings(
    //   android: initializationSettingsAndroid,
    //   iOS: initializationSettingsDarwin,
    // );
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onDidReceiveNotificationResponse: (s) {
    //   print(s);
    // });
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    //await _showNotificationsOnForeground(authorizationStatus);
    _listenToForegroundNotification(authorizationStatus);
    registerBackgroundCallback(authorizationStatus);
  }

  // void onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     context: Get.context!,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(title),
  //       content: Text(body),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: Text('Ok'),
  //           onPressed: () async {
  //             // Navigator.of(context, rootNavigator: true).pop();
  //             // await Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //     builder: (context) => SecondScreen(payload),
  //             //   ),
  //             // );
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<AuthorizationStatus> requestNotificationPermission() async {
    final NotificationSettings settings = await messaging.requestPermission();
    return settings.authorizationStatus;
  }

  Future<String?> getToken() async {
    final String? token = await messaging.getToken();
    fcmDeviceToken = token ?? "";
    if (kDebugMode) {
      print(token);
    }
    return token;
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // final NotificationData notificationData =
    //     NotificationData.fromJson(jsonDecode(message.data['payload']));

    // debugPrint('notificationResponse ${message.data['payload']}');

    // NotificationReference.handleNavigation(notificationData);
  }

  static void registerBackgroundCallback(
    AuthorizationStatus authorizationStatus,
  ) {
    if (authorizationStatus == AuthorizationStatus.authorized) {
      //! background notification tap not workigin android
      // FirebaseMessaging.onBackgroundMessage(
      //   _firebaseMessagingBackgroundHandler,
      // );

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        debugPrint('notificationResponse ${message.data['payload']}');
        //TODO: handle navigation
      });
    }
  }

  Future<void> _showNotificationsOnForeground(
    AuthorizationStatus authorizationStatus,
  ) async {
    if (authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void _listenToForegroundNotification(
    AuthorizationStatus authorizationStatus,
  ) {
    if (authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          final RemoteNotification notification = message.notification!;
          NotificationService().showLocalNotification(
            id: 1,
            title: notification.title ?? '',
            body: notification.body ?? '',
            payload: message.data['payload'],
          );
          //_showLocalAndroidNotification(notification);
        },
        onError: (err) {},
      );
    }
  }

  void _showLocalAndroidNotification(RemoteNotification notification) {
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id, channel.name,
            channelDescription: channel.description,
            // ignore: todo
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
  }
}
