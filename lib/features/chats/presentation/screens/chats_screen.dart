import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:realtime_communication_app/services/notifications/notification_service.dart';
import 'package:realtime_communication_app/utilities/keys.dart';
import 'package:realtime_communication_app/widgets/bottom_nav_bar.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  String? token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomNavBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () async {
                    token = await FirebaseMessaging.instance.getToken();
                    logger.w(token);
                  },
                  icon: const Icon(Icons.upload)),
              IconButton(
                  onPressed: () async {
                    NotificationService().sendNotification(
                        "dg7c0WUuSFSPBR2Q5B81rc:APA91bFoz7_ik0_N6NO-s8GwVjUZL7iexd1MyMsFdhzZQxYdQtOmR-u2PxWJerIpekrLn_HGE2dIYaPaojXhPOcStsgCb4_CUGFZL7CKAYHI-qFAZTcs9Iy5V_QbPTF9JW_DrNTFYFqu");
                  },
                  icon: const Icon(Icons.download)),
            ],
          ),
        ),
      ),
    );
  }
}
