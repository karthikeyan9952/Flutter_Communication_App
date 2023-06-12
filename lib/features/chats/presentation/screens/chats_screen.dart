import 'package:flutter/material.dart';
import 'package:realtime_communication_app/widgets/bottom_nav_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
