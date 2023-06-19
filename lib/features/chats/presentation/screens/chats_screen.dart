import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:realtime_communication_app/utilities/keys.dart';
import 'package:realtime_communication_app/widgets/bottom_nav_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

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
                    String? token = await FirebaseMessaging.instance.getToken();
                    logger.w(token);
                  },
                  icon: const Icon(Icons.upload)),
              IconButton(
                  onPressed: () async {}, icon: const Icon(Icons.download)),
            ],
          ),
        ),
      ),
    );
  }
}
