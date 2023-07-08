import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:realtime_communication_app/features/calls/presentation/screens/video_call_ui.dart';
import 'package:realtime_communication_app/features/calls/presentation/screens/voice_call_ui.dart';
import 'package:realtime_communication_app/utilities/keys.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_communication_app/utilities/providers.dart';

class NotificationService {
  static const String key =
      "AAAAP1Y1Z8I:APA91bEykGpkTBW-WYophAwLqAGYPHsnyVxUnCyerDmPkJH_lYoJgmr2CAwpRLHrWJFq-MYzifFhZ0a712LLbDRdwxeNkwCHS2VKSvNMnDe3wlBR-P6_hXjyOZBhzXvJN16-NQ3-LVhH";

  void initialize() {
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
  }

  void backgroundNotification(RemoteMessage message) {
    // String? title = message.notification!.title,
    //     body = message.notification!.body;
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: 123,
    //         channelKey: "Call_channel",
    //         color: Colors.white,
    //         title: title,
    //         body: body,
    //         category: NotificationCategory.Call,
    //         wakeUpScreen: true,
    //         fullScreenIntent: true,
    //         autoDismissible: false,
    //         backgroundColor: Colors.orange),
    //     actionButtons: [
    //       NotificationActionButton(
    //           key: "ACCEPT",
    //           label: "Accept",
    //           color: Colors.green,
    //           autoDismissible: true),
    //       NotificationActionButton(
    //           key: "REJECT",
    //           label: "Reject",
    //           color: Colors.red,
    //           autoDismissible: true)
    //     ]);
    // AwesomeNotifications().actionStream.listen((event) {
    //   if (event.buttonKeyPressed == "REJECT") {
    //     logger.e("Rejected");
    //   } else if (event.buttonKeyPressed == "ACCEPT") {
    //   } else {
    //     logger.i("Clicked on notification");
    //   }
    // });
  }

  void foregroundNotification(RemoteMessage message, BuildContext context) {
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
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return message.data['type'] == "Video"
              ? CallUI(
                  channelName: message.data['channel'],
                  roleType: ClientRoleType.clientRoleBroadcaster)
              : VoiceCallUI(
                  channelName: message.data['channel'],
                  profilePic: message.data['profile_pic'],
                  userName: body!,
                );
        }));
      } else {
        logger.i("Clicked on notification");
      }
    });
  }

  Future<void> callNotification(String token, String channel, String type,
      {String profilePic = ""}) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$key',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': userProvider.user!.name,
              'title': 'Incoming $type Call',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'channel': channel,
              'type': type,
              'profile_pic': profilePic
            },
            'to': token,
          },
        ),
      );
      response;
    } catch (e) {
      e;
    }
  }
}
