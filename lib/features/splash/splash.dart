import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:realtime_communication_app/constants/local_images.dart';
import 'package:realtime_communication_app/features/authentication/models/user.dart'
    as userModel;
import 'package:realtime_communication_app/services/route/app_routes.dart';
import 'package:realtime_communication_app/utilities/providers.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  User? firebaseUser;
  String? token;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      next();
      getToken();
    });
    super.initState();
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    userProvider.fcmToken = token;
  }

  void next() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    if (firebaseUser != null) {
      userProvider.user = userModel.User(
          id: firebaseUser!.uid,
          name: firebaseUser!.displayName,
          email: firebaseUser!.email,
          fcm: token,
          profilePicture: firebaseUser!.photoURL);
      return context.replace(AppRoutes.chats);
    }
    return context.replace(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    firebaseUser = context.watch<User?>();
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SvgPicture.asset(LocalImages.splashImage),
      )),
    );
  }
}
