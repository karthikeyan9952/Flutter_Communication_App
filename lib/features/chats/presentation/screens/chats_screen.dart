import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:realtime_communication_app/services/notifications/notification_service.dart';
import 'package:realtime_communication_app/utilities/providers.dart';
import 'package:realtime_communication_app/widgets/bottom_nav_bar.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((message) {
      NotificationService().foregroundNotification(message, context);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userProvider.getUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextAppBarHead(data: "Chats"),
              ],
            )),
        bottomNavigationBar: const BottomNavBar(),
        body: const SizedBox());
  }
}
