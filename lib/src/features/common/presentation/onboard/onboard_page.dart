import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/common/presentation/onboard/widget/onboarding_content.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardPage extends ConsumerWidget {
  const OnboardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commonControllerProvider);
    final controller = ref.read(commonControllerProvider.notifier);
    final pageController = PageController();

    return StatusBarWidget(
      brightness: Brightness.dark,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              controller.setLastPage(index == 2);
            },
            children: [
              OnboardingContent(
                  imageAsset: Assets.images.onboard1,
                  imageWidth: 300,
                  imageHeight: 250,
                  title: 'Custom Pakaian Sesuka Hati',
                  subtitle:
                      'Beli Pakaian sesuai desain yang kamu inginkan dengan harga yang terjangkau.'),
              OnboardingContent(
                  imageAsset: Assets.images.onboard2,
                  imageWidth: 300,
                  imageHeight: 250,
                  title: 'Konsultasi Mengenai Pakaian yang cocok untuk Anda',
                  subtitle:
                      'Ceritakan pada kami, kami akan membantu Anda memilih pakaian yang cocok untuk Anda.'),
              OnboardingContent(
                  imageAsset: Assets.images.onboard3,
                  imageWidth: 300,
                  imageHeight: 250,
                  title: 'Lihat Pakaian secara 3D menggunakan Teknologi AR',
                  subtitle:
                      'Tidak perlu khawatir mengenai ukuran pakaian yang akan Anda beli, lihat pakaian secara 3D menggunakan Teknologi AR.'),
            ],
          ),
        ),
        bottomSheet: state.isLastPage
            ? Container(
                padding: EdgeInsets.only(bottom: 52.h, left: 34.w, right: 34.w),
                height: 170.h,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorApp.primary,
                          dotColor: ColorApp.primary.withOpacity(0.30),
                          dotWidth: 12.w,
                          dotHeight: 12.h,
                        ),
                        onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320.w,
                      height: 50.h,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(ColorApp.primary),
                        ),
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          context.goNamed(Routes.login.name);
                        },
                        child: Text(
                          'Mulai Sekarang',
                          style: TypographyApp.onBoardBtnText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.only(bottom: 52.h, left: 34.w, right: 34.w),
                height: 170.h,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorApp.primary,
                          dotColor: ColorApp.primary.withOpacity(0.30),
                          dotWidth: 12.w,
                          dotHeight: 12.h,
                        ),
                        onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120.w,
                          height: 50.h,
                          child: TextButton(
                            onPressed: () {
                              pageController.jumpToPage(2);
                            },
                            child: Text(
                              'Skip',
                              style: TypographyApp.onBoardUnBtnText,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120.w,
                          height: 50.h,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(ColorApp.primary),
                            ),
                            onPressed: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'Next',
                              style: TypographyApp.onBoardBtnText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
