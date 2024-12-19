import 'package:chyess/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypographyApp {
  static TextStyle headline1 = TextStyle(
    fontSize: ScreenUtil().setSp(26),
    fontWeight: FontWeight.w700,
    color: ColorApp.black,
  );

  static TextStyle headline2 = TextStyle(
    fontSize: ScreenUtil().setSp(22),
    fontWeight: FontWeight.w700,
    color: ColorApp.black,
  );

  static TextStyle headline3 = TextStyle(
    fontSize: ScreenUtil().setSp(15),
    fontWeight: FontWeight.w600,
    color: ColorApp.black,
  );

  static TextStyle text1 = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w500,
    color: ColorApp.black,
  );

  static TextStyle text2 = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w400,
    color: ColorApp.black,
  );

  static TextStyle subText1 = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    fontWeight: FontWeight.w300,
    color: ColorApp.black,
  );

  static TextStyle splashLogoName = TextStyle(
    color: ColorApp.secondary,
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
  );

  static TextStyle splashBy = TextStyle(
      color: ColorApp.splash,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      letterSpacing: 0.6.sp);

  static TextStyle splashTeamName = TextStyle(
      color: ColorApp.primary,
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      letterSpacing: 0.48.sp);

  static TextStyle onBoardTitle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );

  static TextStyle onBoardSubTitle = TextStyle(
    color: Colors.black.withOpacity(0.80),
    fontWeight: FontWeight.w300,
    fontSize: 14.sp,
  );

  static TextStyle onBoardBtnText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle onBoardUnBtnText = TextStyle(
    color: ColorApp.primary,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle loginAppName = TextStyle(
    color: ColorApp.secondary,
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
  );

  static TextStyle loginTitle = TextStyle(
    color: ColorApp.black,
    fontWeight: FontWeight.w500,
    fontSize: 30.sp,
  );

  static TextStyle loginBtn = TextStyle(
    color: ColorApp.white,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle loginOffInput = TextStyle(
    color: const Color(0xFF9D9D9D),
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle loginOnInput = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle loginForgot = TextStyle(
    color: ColorApp.primary,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle whiteOnBtnSmall = TextStyle(
    fontSize: 13.sp,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  static TextStyle homeDetName = TextStyle(
    color: ColorApp.secondary,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );

  static TextStyle profileJob = TextStyle(
    color: ColorApp.primary,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
  static TextStyle profileItemTitle = TextStyle(
    color: Colors.black.withOpacity(0.70),
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );
  static TextStyle profileItem = TextStyle(
    color: const Color(0xFF231F20),
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );

  static TextStyle searchText = TextStyle(
    color: const Color(0xFF001C34),
    fontWeight: FontWeight.w800,
    fontSize: 16.sp,
  );

  static TextStyle hintSearch = TextStyle(
    color: const Color(0xFF8E9195),
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );

  static TextStyle txtSearch = TextStyle(
    color: const Color(0xFF001C34),
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
}
