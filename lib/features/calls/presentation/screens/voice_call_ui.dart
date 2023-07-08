import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realtime_communication_app/constants/agora.dart';
import 'package:realtime_communication_app/utilities/extensions/context_extension.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';

class VoiceCallUI extends StatefulWidget {
  const VoiceCallUI(
      {super.key,
      required this.channelName,
      required this.profilePic,
      required this.userName});
  final String channelName;
  final String profilePic;
  final String userName;

  @override
  State<VoiceCallUI> createState() => VoiceCallUIState();
}

class VoiceCallUIState extends State<VoiceCallUI> {
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance
  bool muted = false;
  bool isOnSpeaker = false;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Voice Calling'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              TextAppBarHead(data: widget.userName),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: widget.profilePic,
                  height: context.widthHalf(),
                  width: context.widthHalf(),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(height: 40, child: Center(child: _status())),
              const Spacer(),
              const Spacer(),
              toolBar()
              // Status text
              // Button Row
            ],
          ),
        ));
  }

  Widget toolBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () => setState(() {
              muted = !muted;
              agoraEngine.muteLocalAudioStream(muted);
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
            onPressed: () {
              leave();
              Navigator.pop(context);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15),
            child: const Icon(Icons.call_end, color: Colors.white, size: 35),
          ),
          RawMaterialButton(
            onPressed: () => setState(() {
              isOnSpeaker = !isOnSpeaker;
              agoraEngine.setEnableSpeakerphone(isOnSpeaker);
            }),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              isOnSpeaker ? Icons.volume_up : Icons.phone_in_talk,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _status() {
    String statusText;
    if (!_isJoined) {
      statusText = 'Calling...';
    } else if (_remoteUid == null) {
      statusText = 'Ringing...';
    } else {
      statusText = 'Connected to remote user, uid:$_remoteUid';
    }

    return TextCustom(
      value: statusText,
    );
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine
        .initialize(const RtcEngineContext(appId: AgoraConstants.appID));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
    join();
  }

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: AgoraConstants.token,
      channelId: widget.channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  @override
  void dispose() {
    agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }
}
