import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_communication_app/features/authentication/presentaion/providers/user_provider.dart';
import 'package:realtime_communication_app/features/chats/presentation/widgets/user_card.dart';
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
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextAppBarHead(data: "Users"),
                  ],
                )),
            bottomNavigationBar: const BottomNavBar(),
            body: RefreshIndicator(
              onRefresh: () async {
                await provider.getUsers();
              },
              child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) =>
                      UserCard(user: provider.users[index])),
            ));
      },
    );
  }
}
