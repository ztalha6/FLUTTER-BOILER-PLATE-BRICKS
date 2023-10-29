import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// /import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  //final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        //TODO: handle navigation
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    tz.initializeTimeZones();
    // tz.setLocalLocation(
    //   tz.getLocation(
    //     await FlutterNativeTimezone.getLocalTimezone(),
    //   ),
    // );
  }

  Future<NotificationDetails> _notificationDetails() async {
    // final localNotifications = FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
      //largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
      color: Color(0xff2196f3),
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      threadIdentifier: "thread1",
    );

    // final details = await localNotifications.getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {
    //   behaviorSubject.add(details.payload!);
    // }
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );

    return platformChannelSpecifics;
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    debugPrint('id $id');
    debugPrint('---------------payload--------------- \n $payload');
    debugPrint('$payload');
    debugPrint('---------------payload--------------- \n $payload');
  }

//! call this method in FCM Notification service
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showScheduledLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required int seconds,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      platformChannelSpecifics,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // androidScheduleMode: AndroidScheduleMode.exact,
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint('notificationResponse ${notificationResponse.payload}');
  //TODO: handle navigation
}
