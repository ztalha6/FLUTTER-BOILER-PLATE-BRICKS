# Flutter Local Notification 🚀

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to get the Firebase messenging service.

_Generated by [mason][1] 🧱_

## Setup

Add the following lines to your main.dart file.

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // add this line
  await setupFirebase();
  runApp(const BaseWidget(Routes.SPLASH));
}

// add this method
Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FCMNotificationService fcmNotificationService =
      FCMNotificationService();
  final AuthorizationStatus authorizationStatus =
      await fcmNotificationService.requestNotificationPermission();
  await fcmNotificationService.initialize(authorizationStatus);
  final NotificationService notificationService = NotificationService();
  notificationService.initializePlatformNotifications();
}

```

## Dependencies

This brick is dependent on the following dependencies.
You have to add them in your pubspec.ymal under dependencies:

```dart

  firebase_messaging: ^14.6.4
  cloud_firestore:

```