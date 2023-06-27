import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:realtime_communication_app/features/authentication/presentaion/providers/user_provider.dart';
import 'package:realtime_communication_app/services/route/app_routes.dart';
import 'package:realtime_communication_app/utilities/providers.dart';
import 'package:realtime_communication_app/widgets/bottom_nav_bar.dart';
import 'package:realtime_communication_app/widgets/space.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextAppBarHead(data: "Profile")],
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(space),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(provider.user!.profilePicture!)),
                  ],
                ),
                const HeightFull(),
                TextCustom(
                    value: provider.user!.name!,
                    size: 18,
                    fontWeight: FontWeight.bold),
                const HeightHalf(),
                TextCustom(
                  value: provider.user!.email!,
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () =>
                        loginProvider.googleSignout().then((value) {
                          context.pushReplacement(AppRoutes.login);
                        }),
                    child: const BtnText(label: "Logout"))
              ],
            ),
          )),
        );
      },
    );
  }
}
