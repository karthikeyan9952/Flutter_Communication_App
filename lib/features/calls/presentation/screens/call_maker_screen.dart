import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_communication_app/services/network/signaling.dart';
import 'package:realtime_communication_app/services/notifications/notification_service.dart';
import 'package:realtime_communication_app/widgets/space.dart';

class CallMakerScreen extends StatefulWidget {
  const CallMakerScreen({Key? key, required this.fcm}) : super(key: key);
  final String fcm;

  @override
  State<CallMakerScreen> createState() => _CallMakerScreenState();
}

class _CallMakerScreenState extends State<CallMakerScreen> {
  Signaling signaling = Signaling();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _localRenderer.initialize();
      _remoteRenderer.initialize();

      signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
        setState(() {});
      });
      createRoom();
    });

    super.initState();
  }

  createRoom() async {
    await signaling.openUserMedia(_localRenderer, _remoteRenderer);
    roomId = await signaling.createRoom(_remoteRenderer);
    NotificationService().callNotification(widget.fcm, roomId!);
    setState(() {});
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: RTCVideoView(_localRenderer, mirror: true)),
            SizedBox(
              height: 150,
              width: 100,
              child: RTCVideoView(_remoteRenderer),
            ),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () => signaling
                            .hangUp(_localRenderer)
                            .then((value) => context.pop()),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100)),
                          child:
                              const Icon(Icons.call_end, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const HeightFull()
                ],
              ),
            )
          ],
        ),
      ),
    )
        //  Column(
        //   children: [
        //     Wrap(
        //       children: [
        //         ElevatedButton(
        //           onPressed: () {
        //             signaling.openUserMedia(_localRenderer, _remoteRenderer);
        //           },
        //           child: const Text("Open camera & microphone"),
        //         ),
        //         const SizedBox(
        //           width: 8,
        //         ),
        //         ElevatedButton(
        //           onPressed: () async {
        //             roomId = await signaling.createRoom(_remoteRenderer);
        //             textEditingController.text = roomId!;
        //             setState(() {});
        //           },
        //           child: const Text("Create room"),
        //         ),
        //         const SizedBox(
        //           width: 8,
        //         ),
        //         ElevatedButton(
        //           onPressed: () {
        //             // Add roomId
        //             signaling.joinRoom(
        //               textEditingController.text.trim(),
        //               _remoteRenderer,
        //             );
        //           },
        //           child: const Text("Join room"),
        //         ),
        //         const SizedBox(
        //           width: 8,
        //         ),
        //         ElevatedButton(
        //           onPressed: () {
        //             signaling.hangUp(_localRenderer);
        //           },
        //           child: const Text("Hangup"),
        //         )
        //       ],
        //     ),
        //     const SizedBox(height: 8),
        //     Row(
        //       children: [
        //         SizedBox(
        //             height: 100,
        //             width: 200,
        //             child: RTCVideoView(_localRenderer, mirror: true)),
        //         SizedBox(
        //             height: 100,
        //             width: 200,
        //             child: RTCVideoView(_remoteRenderer)),
        //       ],
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           const Text("Join the following Room: "),
        //           Flexible(
        //             child: TextFormField(
        //               controller: textEditingController,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //     const SizedBox(height: 8)
        //   ],
        // ),
        );
  }
}
