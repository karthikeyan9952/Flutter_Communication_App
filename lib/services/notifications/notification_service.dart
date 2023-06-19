import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:realtime_communication_app/utilities/keys.dart';
import 'package:http/http.dart' as http;

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
  }

  void foregroundNotification(RemoteMessage message, BuildContext context) {
    String? title = message.notification!.title,
        body = message.notification!.body;
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Scaffold(
              backgroundColor: Colors.black.withOpacity(.4),
              body: Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width,
                            child: Text("data")),
                      ))));
        });
  }

  Future<void> sendNotification(String token) async {
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
              'body': "Karthikeyan",
              'title': 'Incoming Call',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
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
