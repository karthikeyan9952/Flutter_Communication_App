import 'package:flutter/material.dart';
import 'package:realtime_communication_app/widgets/bottom_nav_bar.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
