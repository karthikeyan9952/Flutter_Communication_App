import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:realtime_communication_app/constants/agora.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';

class CallUI extends StatefulWidget {
  const CallUI({super.key, required this.channelName, required this.roleType});
  final String channelName;
  final ClientRoleType roleType;

  @override
  State<CallUI> createState() => _CallUIState();
}

class _CallUIState extends State<CallUI> {
  final users = <int>[];
  final infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine engine;
  int? _remoteUid;
  bool _localUserJoined = false;

  @override
  void initState() {
    super.initState();
    initialze();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
        actions: [
          IconButton(
              onPressed: () => setState(() {
                    viewPanel = !viewPanel;
                  }),
              icon: const Icon(Icons.info))
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          toolBar()
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.roleType == ClientRoleType.clientRoleBroadcaster) {
      list.add(AgoraVideoView(
          controller: VideoViewController(
              rtcEngine: engine, canvas: const VideoCanvas())));
    }
    for (var uid in users) {
      list.add(AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine,
          canvas: VideoCanvas(uid: uid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      ));
    }
    final views = list;
    return Column(
      children:
          List.generate(views.length, (index) => Expanded(child: views[index])),
    );
  }

  Widget toolBar() {
    if (widget.roleType == ClientRoleType.clientRoleAudience) {
      return const SizedBox();
    }
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () => setState(() {
              muted = !muted;
              engine.muteLocalAudioStream(muted);
            }),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: Colors.blueAccent,
            ),
          ),
          RawMaterialButton(
            onPressed: () => Navigator.pop(context),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15),
            child: const Icon(Icons.call_end, color: Colors.white, size: 35),
          ),
          RawMaterialButton(
            onPressed: () => engine.switchCamera(),
            elevation: 2.0,
            fillColor: Colors.white,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }

  Widget panel() {
    return Visibility(
        visible: viewPanel,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 48),
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: .5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: ListView.builder(
                    reverse: true,
                    itemCount: infoStrings.length,
                    itemBuilder: (context, index) {
                      if (infoStrings.isEmpty) {
                        return const TextCustom(value: "Null");
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextCustom(
                                value: infoStrings[index],
                                color: Colors.grey,
                              ),
                            ))
                          ],
                        ),
                      );
                    }),
              ),
            )));
  }

  Future<void> initialze() async {
    if (AgoraConstants.appID.isEmpty) {
      infoStrings.add("AppID is empty.");
      setState(() {});
      return;
    }
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: AgoraConstants.appID,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    _addAgoraEventHandlers();
    await engine.setClientRole(role: widget.roleType);
    await engine.enableVideo();
    await engine.startPreview();
    await engine.joinChannel(
      token: AgoraConstants.token,
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    users.clear();
    engine.leaveChannel();
    engine.release();
    super.dispose();
  }

  void _addAgoraEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (err, msg) => setState(() {
          final info = "Error $msg";
          infoStrings.add(info);
        }),
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            infoStrings.add("local user ${connection.localUid} joined");
            _localUserJoined = true;
          });
        },
        onLeaveChannel: (connection, stats) => setState(() {
          infoStrings.add("Leaving channel");
          _localUserJoined = false;
          users.clear();
        }),
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            infoStrings.add("remote user $remoteUid joined");
            users.add(remoteUid);
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            infoStrings.add("remote user $remoteUid left channel");
            users.remove(remoteUid);
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          setState(() {
            infoStrings.add(
                '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          });
        },
      ),
    );
  }
}
