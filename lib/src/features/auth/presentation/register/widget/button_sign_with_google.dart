import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonSignWithGoogle extends StatelessWidget {
  const ButtonSignWithGoogle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 46.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.icGoogle.svg(
              width: 24.w,
              height: 24.h,
            ),
            Gap.w8,
            Text(
              text,
              style: TypographyApp.headline3.copyWith(
                color: Colors.black.withOpacity(.75),
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
