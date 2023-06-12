import 'package:flutter/material.dart';

double space = 14;

class HeightFull extends StatelessWidget {
  const HeightFull({super.key, this.multiplier = 1});
  final int? multiplier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space * multiplier!,
    );
  }
}

class WidthFull extends StatelessWidget {
  const WidthFull({super.key, this.multiplier = 1});
  final int? multiplier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: space * multiplier!,
    );
  }
}

class HeightHalf extends StatelessWidget {
  const HeightHalf({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space / 2,
    );
  }
}

class WidthHalf extends StatelessWidget {
  const WidthHalf({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: space / 2,
    );
  }
}
