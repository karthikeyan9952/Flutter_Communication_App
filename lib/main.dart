import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:realtime_communication_app/services/notifications/notification_service.dart';
import 'package:realtime_communication_app/services/route/app_router.dart';
import 'package:realtime_communication_app/services/theme/theme_manager.dart';
import 'package:realtime_communication_app/utilities/providers.dart';

import 'firebase_options.dart';
import 'services/theme/theme_constants.dart';
import 'utilities/keys.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async =>
    NotificationService().backgroundNotification(message);

void main() async {
  NotificationService().initialize();
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
