import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_communication_app/features/authentication/presentaion/screens/login_screen.dart';
import 'package:realtime_communication_app/features/chats/presentation/screens/chats_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const ChatsScreen();
    }
    return const LoginScreen();
  }
}
