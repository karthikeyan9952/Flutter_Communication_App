import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_communication_app/config/color_config.dart';
import 'package:realtime_communication_app/services/route/app_routes.dart';
import 'package:realtime_communication_app/widgets/space.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double size = 28;
    return Container(
      height: 58,
      decoration: const BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: space),
      child: Row(
        children: [
          NavItem(
              route: AppRoutes.chats,
              icon: GoRouter.of(context).location == AppRoutes.chats
                  ? Icon(CupertinoIcons.chat_bubble_fill,
                      color: ColorConfig.primary, size: size)
                  : Icon(CupertinoIcons.chat_bubble, size: size)),
          NavItem(
              route: AppRoutes.calls,
              icon: GoRouter.of(context).location == AppRoutes.calls
                  ? Icon(CupertinoIcons.phone_fill, color: ColorConfig.primary, size: size)
                  :  Icon(CupertinoIcons.phone, size: size)),
          NavItem(
              route: AppRoutes.profile,
              icon: GoRouter.of(context).location == AppRoutes.profile
                  ? Icon(CupertinoIcons.person_fill, color: ColorConfig.primary, size: size)
                  :  Icon(CupertinoIcons.person, size: size)),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.route,
    required this.icon,
  });
  final String route;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        onPressed: () => context.replace(route),
        icon: icon,
      ),
    );
  }
}
