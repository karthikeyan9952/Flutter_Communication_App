import 'package:flutter/material.dart';
import 'package:realtime_communication_app/config/color_config.dart';
import 'package:realtime_communication_app/constants/local_images.dart';
import 'package:realtime_communication_app/widgets/text_widget.dart';

class TextFieldMobile extends StatelessWidget {
  final TextEditingController controller;
  const TextFieldMobile({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConfig.pureWhite),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        obscureText: false,
        cursorColor: ColorConfig.primary,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 2),
            prefixIcon: InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 12),
                  Image.asset(
                    LocalImages.indianFlag,
                    width: 36,
                  ),
                  const SizedBox(width: 6),
                  const Text("+91"),
                  const SizedBox(width: 6),
                ],
              ),
            ),
            fillColor: ColorConfig.pureWhite,
            filled: false,
            counterText: "",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorConfig.primary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.3)))),
      ),
    );
  }
}

class TextFieldCommon extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final TextInputType? textInputType;
  const TextFieldCommon(
      {super.key, required this.controller, this.hint, this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(color: ColorConfig.pureWhite),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: false,
        cursorColor: ColorConfig.primary,
        style: const TextStyle(),
        decoration: InputDecoration(
            fillColor: ColorConfig.pureWhite,
            filled: false,
            counterText: "",
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorConfig.primary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.3)))),
      ),
    );
  }
}

class TextFieldForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? textInputType;
  const TextFieldForm(
      {super.key,
      required this.controller,
      this.hint,
      this.textInputType,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextCustom(value: label, color: Colors.grey),
        TextFormField(
          controller: controller,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: false,
          cursorColor: ColorConfig.primary,
          style: const TextStyle(),
          decoration: InputDecoration(
            fillColor: ColorConfig.pureWhite,
            filled: false,
            counterText: "",
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class TextFieldSearch extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Widget? prefix;
  final String? hint;
  final Widget? suffix;
  final Color? backgroundColor;
  const TextFieldSearch({
    super.key,
    required this.controller,
    this.prefix,
    this.hint,
    this.suffix,
    required this.focusNode,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        focusNode: focusNode,
        obscureText: false,
        onTap: () {},
        decoration: InputDecoration(
            fillColor: ColorConfig.pureWhite,
            prefixIcon: prefix,
            suffixIcon: suffix,
            filled: false,
            isDense: true,
            counterText: "",
            hintText: hint,
            contentPadding: const EdgeInsets.only(top: 12),
            hintStyle: TextStyle(
                fontSize: 13, color: ColorConfig.grey.withOpacity(.8)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(color: ColorConfig.primary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.3)))),
      ),
    );
  }
}
