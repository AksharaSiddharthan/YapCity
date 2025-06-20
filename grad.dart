import 'package:flutter/material.dart';
import 'package:yaptest/main.dart';

//gradient for the app


class GradientBg extends StatelessWidget {
  final Widget child;
  const GradientBg({required this.child, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
