import 'package:flutter/material.dart';

class TextAppBarHead extends StatelessWidget {
  final String data;
  final Color? color;
  const TextAppBarHead({
    super.key,
    required this.data,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(data,
        textAlign: TextAlign.center,
        style:
            TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w600));
  }
}

class BtnText extends StatelessWidget {
  const BtnText({
    super.key,
    required this.label,
    this.color,
    this.size,
  });

  final String label;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
            fontSize: size ?? 16, color: color, fontWeight: FontWeight.w600));
  }
}

class TextUnerlined extends StatelessWidget {
  final String value;
  const TextUnerlined({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 14,
          fontWeight: FontWeight.w500),
    );
  }
}

class TextCustom extends StatelessWidget {
  final String value;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? align;
  const TextCustom({
    super.key,
    required this.value,
    this.size,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      style:
          TextStyle(fontSize: size ?? 14, color: color, fontWeight: fontWeight),
    );
  }
}

class TextH1 extends StatelessWidget {
  final String value;
  const TextH1({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Text(value,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: .2));
  }
}

class TextSTD extends StatelessWidget {
  final String value;
  final Color? color;
  const TextSTD({
    super.key,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}

class TextS extends StatelessWidget {
  final String value;
  final Color? color;
  const TextS({
    super.key,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(color: color, fontSize: 14),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.text,
    this.moreAction,
  });
  final String text;
  final VoidCallback? moreAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextCustom(
            value: text,
            fontWeight: FontWeight.w600,
            size: 18,
          ),
          InkWell(onTap: moreAction, child: const TextUnerlined(value: "more"))
        ],
      ),
    );
  }
}
