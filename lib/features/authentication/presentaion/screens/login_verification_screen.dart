import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:realtime_communication_app/config/color_config.dart';
import 'package:realtime_communication_app/constants/local_images.dart';
import 'package:realtime_communication_app/widgets/space.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';

class LoginVerficationScreen extends StatefulWidget {
  const LoginVerficationScreen({super.key});

  @override
  State<LoginVerficationScreen> createState() => _LoginVerficationScreenState();
}

class _LoginVerficationScreenState extends State<LoginVerficationScreen> {
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextAppBarHead(data: "OTP Verification")),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.all(space),
        children: [
          SvgPicture.asset(LocalImages.enterOTP, height: 350),
          const TextCustom(
              value: "Enter the OTP sent to +91 9099076123", size: 16),
          const HeightFull(),
          const HeightFull(),
          Pinput(length: 6, controller: _otpController),
          const HeightFull(),
          const HeightFull(),
          const HeightFull(),
          ElevatedButton(
              onPressed: () {}, child: const BtnText(label: "Verify")),
          const HeightFull(multiplier: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextCustom(value: "Didn't received code?"),
              TextButton(
                  onPressed: () {},
                  child:
                      TextCustom(value: "Resend", color: ColorConfig.primary))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: TextCustom(
                      value: "Change number", color: ColorConfig.primary))
            ],
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
