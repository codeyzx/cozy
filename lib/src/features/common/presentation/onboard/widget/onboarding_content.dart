import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingContent extends StatelessWidget {
  final SvgGenImage imageAsset;
  final double imageWidth;
  final double imageHeight;
  final String title;
  final String subtitle;

  const OnboardingContent({
    super.key,
    required this.imageAsset,
    required this.imageWidth,
    required this.imageHeight,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 167.h),
      child: Column(
        children: [
          Center(
            child: imageAsset.svg(
              width: imageWidth.w,
              height: imageHeight.h,
            ),
          ),
          SizedBox(
            height: 13.46.h,
          ),
          Text(
            title,
            style: TypographyApp.onBoardTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            width: 350.w,
            child: Text(
              subtitle,
              style: TypographyApp.onBoardSubTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
