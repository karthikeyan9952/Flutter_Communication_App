import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_communication_app/features/calls/presentation/screens/video_call_ui.dart';
import 'package:realtime_communication_app/features/calls/presentation/screens/voice_call_ui.dart';
import 'package:realtime_communication_app/services/notifications/notification_service.dart';
import 'package:realtime_communication_app/utilities/providers.dart';
import 'package:realtime_communication_app/widgets/space.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';

import '../../../authentication/models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  width: 50,
                  height: 50,
                  imageUrl: user.profilePicture!,
                  fit: BoxFit.cover,
                )),
            const WidthFull(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  value: user.name!,
                  fontWeight: FontWeight.w500,
                ),
                TextCustom(
                  size: 12,
                  value: user.email!,
                  color: Colors.grey,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      await NotificationService()
                          .callNotification(user.fcm!, "Testing", "Video");
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallUI(
                                channelName: "Testing",
                                roleType: ClientRoleType.clientRoleBroadcaster),
                          ));
                    },
                    icon: const Icon(
                      CupertinoIcons.videocam,
                      size: 28,
                    )),
                IconButton(
                    onPressed: () async {
                      await NotificationService().callNotification(
                          user.fcm!, "Testing", "Voice",
                          profilePic: userProvider.user!.profilePicture!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VoiceCallUI(
                              channelName: "Testing",
                              profilePic: user.profilePicture!,
                              userName: user.name!,
                            ),
                          ));
                    },
                    icon: const Icon(CupertinoIcons.phone)),
              ],
            )
          ],
        ),
        const HeightFull(),
        const HeightHalf()
      ],
    );
  }
}
