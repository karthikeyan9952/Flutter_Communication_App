import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:realtime_communication_app/services/network/signaling.dart';
import 'package:realtime_communication_app/services/notifications/notification_service.dart';
import 'package:realtime_communication_app/utilities/keys.dart';
import 'package:realtime_communication_app/widgets/bottom_nav_bar.dart';

// class ChatsScreen extends StatefulWidget {
//   const ChatsScreen({super.key});

//   @override
//   State<ChatsScreen> createState() => _ChatsScreenState();
// }

// class _ChatsScreenState extends State<ChatsScreen> {
//   String? token;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: false),
//       bottomNavigationBar: const BottomNavBar(),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                   onPressed: () async {
//                     token = await FirebaseMessaging.instance.getToken();
//                     logger.w(token);
//                   },
//                   icon: const Icon(Icons.upload)),
//               IconButton(
//                   onPressed: () async {
//                     NotificationService().sendNotification(
//                         "dg7c0WUuSFSPBR2Q5B81rc:APA91bFoz7_ik0_N6NO-s8GwVjUZL7iexd1MyMsFdhzZQxYdQtOmR-u2PxWJerIpekrLn_HGE2dIYaPaojXhPOcStsgCb4_CUGFZL7CKAYHI-qFAZTcs9Iy5V_QbPTF9JW_DrNTFYFqu");
//                   },
//                   icon: const Icon(Icons.download)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.i(textEditingController.text);

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Flutter Explained - WebRTC"),
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              ElevatedButton(
                onPressed: () {
                  signaling.openUserMedia(_localRenderer, _remoteRenderer);
                },
                child: Text("Open camera & microphone"),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () async {
                  roomId = await signaling.createRoom(_remoteRenderer);
                  textEditingController.text = roomId!;
                  setState(() {});
                },
                child: Text("Create room"),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add roomId
                  signaling.joinRoom(
                    textEditingController.text.trim(),
                    _remoteRenderer,
                  );
                },
                child: Text("Join room"),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  signaling.hangUp(_localRenderer);
                },
                child: Text("Hangup"),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                  height: 100,
                  width: 200,
                  child: RTCVideoView(_localRenderer, mirror: true)),
              SizedBox(
                  height: 100,
                  width: 200,
                  child: RTCVideoView(_remoteRenderer)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Join the following Room: "),
                Flexible(
                  child: TextFormField(
                    controller: textEditingController,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
