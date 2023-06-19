import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_communication_app/constants/local_images.dart';
import 'package:realtime_communication_app/services/route/app_routes.dart';
import 'package:realtime_communication_app/utilities/keys.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => next());
    FirebaseMessaging.onMessage.listen((message) {
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
      AwesomeNotifications().actionStream.listen((event) {
        if (event.buttonKeyPressed == "REJECT") {
          logger.e("Rejected");
        } else if (event.buttonKeyPressed == "ACCEPT") {
          logger.w("Accepted");
        } else {
          logger.i("Clicked on notification");
        }
      });
    });
    super.initState();
  }

  void next() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    context.push(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SvgPicture.asset(LocalImages.splashImage),
      )),
    );
  }
}
