import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/shared/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(commonControllerProvider.notifier).checkSplash();

    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: ColorApp.primary,
        body: SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Column(
            children: [
              const Spacer(flex: 4),
              Assets.images.cozyLogo.image(
                width: context.screenWidthPercentage(0.8),
                fit: BoxFit.fitWidth,
              ),
              const Spacer(flex: 4),
              Text("By",
                  style: TypographyApp.splashBy.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.6.sp,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp)),
              Text("Virtus",
                  style: TypographyApp.splashTeamName.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.48.sp,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp)),
              Gap.h28
            ],
          ),
        ),
      ),
    );
  }
}
