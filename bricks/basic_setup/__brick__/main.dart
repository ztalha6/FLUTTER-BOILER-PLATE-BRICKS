import 'package:flutter/material.dart';
import 'app/routes/app_pages.dart';
import 'data/env/env.dart';
import 'data/env/envs.dart';
import 'data/widgets/base_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  Env.currentEnv = Envs.DevEnv;
  runApp(const BaseWidget(Routes.SPLASH));
}

Future<void> setupFirebase() async {
  /*
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FCMNotificationService notificationService = FCMNotificationService();
  final AuthorizationStatus authorizationStatus =
      await notificationService.requestNotificationPermission();
  await notificationService.initialize(authorizationStatus);
  FCMNotificationService.registerBackgroundCallback(authorizationStatus);
  await FirebaseAnalytics.instance.logBeginCheckout(
    value: 10.0,
    currency: 'USD',
    items: [
      AnalyticsEventItem(itemName: 'Socks', itemId: 'xjw73ndnw', price: 10.0),
    ],
    coupon: '10PERCENTOFF',
  );
  */
}
