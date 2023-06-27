import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_communication_app/services/route/app_routes.dart';
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
                  width: 58,
                  height: 58,
                  imageUrl: user.profilePicture!,
                  fit: BoxFit.cover,
                )),
            const WidthFull(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  value: user.name!,
                  size: 16,
                  fontWeight: FontWeight.w500,
                ),
                TextCustom(
                  value: user.email!,
                  color: Colors.grey,
                ),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () =>
                    context.push(AppRoutes.callMaker, extra: user.fcm),
                icon: const Icon(CupertinoIcons.phone))
          ],
        ),
        const HeightFull(),
        const HeightHalf()
      ],
    );
  }
}
