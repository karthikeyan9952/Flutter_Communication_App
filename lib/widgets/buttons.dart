import 'package:flutter/material.dart';
import 'package:realtime_communication_app/utilities/extensions/context_extension.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final String imgPath;
  final double? width;
  final VoidCallback? voidCallback;
  final Color? color;
  const SocialButton(
      {super.key,
      required this.label,
      this.width,
      this.voidCallback,
      this.color,
      required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: width ?? context.widthFull(),
      child: ElevatedButton(
          onPressed: voidCallback,
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(8))),
              backgroundColor:
                  MaterialStateProperty.all(color ?? Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imgPath, height: 24),
              const SizedBox(width: 12),
              BtnText(label: label, size: 15, color: Colors.black87),
            ],
          )),
    );
  }
}
