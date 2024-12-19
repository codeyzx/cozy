import 'package:chyess/src/constants/constants.dart';
import 'package:flutter/material.dart';

class PaddingWidget extends StatelessWidget {
  final Widget child;
  final double? horizontalPadding;
  final double? verticalPadding;
  const PaddingWidget({
    super.key,
    required this.child,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? SizeApp.w24,
        vertical: verticalPadding ?? 0,
      ),
      child: child,
    );
  }
}
