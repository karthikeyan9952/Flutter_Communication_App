import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:realtime_communication_app/services/route/app_router.dart';
import 'package:realtime_communication_app/services/theme/theme_manager.dart';
import 'package:realtime_communication_app/utilities/providers.dart';

import 'firebase_options.dart';
import 'services/theme/theme_constants.dart';
import 'utilities/keys.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  String? title = message.notification!.title,
      body = message.notification!.body;
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 123,
          channelKey: "Call_channel",
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.orange),
      actionButtons: [
        NotificationActionButton(
            key: "ACCEPT",
            label: "Accept",
            color: Colors.green,
            autoDismissible: true),
        NotificationActionButton(
            key: "REJECT",
            label: "Reject",
            color: Colors.red,
            autoDismissible: true)
      ]);
}

void main() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "Call_channel",
        channelName: "Call Channel",
        channelDescription: "Channel of calling",
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone)
  ]);
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, theme, child) {
        return MaterialApp.router(
          key: materialKey,
          title: 'Realtime Communication App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: theme.themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
