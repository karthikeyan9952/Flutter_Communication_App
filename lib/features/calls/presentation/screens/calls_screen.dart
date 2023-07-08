import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_communication_app/features/authentication/presentaion/providers/user_provider.dart';
import 'package:realtime_communication_app/features/calls/presentation/screens/video_call_ui.dart';
import 'package:realtime_communication_app/features/chats/presentation/widgets/user_card.dart';
import 'package:realtime_communication_app/services/notifications/notification_service.dart';
import 'package:realtime_communication_app/utilities/keys.dart';
import 'package:realtime_communication_app/utilities/providers.dart';
import 'package:realtime_communication_app/widgets/bottom_nav_bar.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
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

  final channelController = TextEditingController();
  bool hasError = false;
  ClientRoleType role = ClientRoleType.clientRoleBroadcaster;

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
                    TextAppBarHead(data: "Calls"),
                  ],
                )),
            bottomNavigationBar: const BottomNavBar(),
            // body: Padding(
            //   padding: const EdgeInsets.all(12),
            //   child: Column(
            //     children: [
            //       TextField(
            //         controller: channelController,
            //         decoration: InputDecoration(
            //             hintText: "Channel Name",
            //             errorText: hasError ? "Channel name is required" : null),
            //       ),
            //       SizedBox(height: 12),
            //       RadioListTile(
            //           title: TextCustom(value: "Broadcaster"),
            //           value: ClientRoleType.clientRoleBroadcaster,
            //           groupValue: role,
            //           onChanged: (value) => setState(() {
            //                 role = value!;
            //               })),
            //       RadioListTile(
            //           title: TextCustom(value: "Audience"),
            //           value: ClientRoleType.clientRoleAudience,
            //           groupValue: role,
            //           onChanged: (value) => setState(() {
            //                 role = value!;
            //               })),
            //       ElevatedButton(onPressed: onJoin, child: BtnText(label: "Join"))
            //     ],
            //   ),
            // ),
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

  Future<void> onJoin() async {
    hasError = channelController.text.isEmpty;
    setState(() {});
    if (hasError) {
      return;
    }
    await _handleCameraPermission(Permission.camera);
    await _handleMicPermission(Permission.microphone);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CallUI(channelName: channelController.text, roleType: role)));
  }

  @override
  void dispose() {
    channelController.dispose();
    super.dispose();
  }

  Future _handleCameraPermission(Permission permission) async {
    final status = await permission.request();
    logger.i(status);
  }

  Future _handleMicPermission(Permission permission) async {
    final status = await permission.request();
    logger.i(status);
  }
}
