import 'package:cached_network_image/cached_network_image.dart';
import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/checkmark_indicator/checkmark_indicator.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/common/presentation/profile/presentation/profile_controller.dart';
import 'package:chyess/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commonControllerProvider);
    final user = state.userValue.asData?.value;
    return Scaffold(
      body: StatusBarWidget(
        brightness: Brightness.dark,
        child: CheckMarkIndicator(
          onRefresh: () async =>
              await ref.read(commonControllerProvider.notifier).getProfile(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      user?.photoUrl != null && user?.photoUrl != ''
                          ? CircleAvatar(
                              radius: 30.r,
                              backgroundImage: CachedNetworkImageProvider(
                                user?.photoUrl ?? '',
                              ),
                              backgroundColor: Colors.white,
                            )
                          : CircleAvatar(
                              radius: 30.r,
                              backgroundImage: Assets.images.profileDefaultImg
                                  .image(
                                    width: 60.w,
                                    height: 60.h,
                                  )
                                  .image,
                              backgroundColor: Colors.white,
                            ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 220.w,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${user?.name}',
                                  style: TypographyApp.homeDetName,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            '${user?.email}',
                            style: TypographyApp.profileJob,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    width: 1.sw,
                    height: 0.6.h,
                    color: ColorApp.shadow,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Akun Kamu",
                        style: TypographyApp.profileItemTitle,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      InkWell(
                        onTap: () async {
                          // final nutritionController =
                          //     ref.read(nutritionControllerProvider.notifier);

                          // await nutritionController
                          //     .getNutrition(state.user.asData?.value?.id ?? '');

                          // nutritionController.setTextFieldValue();
                          // controller.setTextField();
                          // ref
                          //     .read(goRouterProvider)
                          //     .pushNamed(Routes.profileEdit.name);
                          ref
                              .read(profileControllerProvider.notifier)
                              .setTextField(user);
                          ref
                              .read(goRouterProvider)
                              .pushNamed(Routes.profileEdit.name);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.person_rounded,
                              color: ColorApp.lightGrey,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              width: 0.8.sw,
                              padding: EdgeInsets.only(bottom: 16.h),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: ColorApp.border,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ubah Profil",
                                    style: TypographyApp.profileItem,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: ColorApp.splash,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      user?.role == 'designer'
                          ? InkWell(
                              onTap: () async {
                                context.pushNamed(Routes.productManage.name);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.shopping_bag,
                                    color: ColorApp.lightGrey,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    width: 0.8.sw,
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: ColorApp.border,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tambahkan Produk",
                                          style: TypographyApp.profileItem,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: ColorApp.splash,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () async {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.lock_rounded,
                                    color: ColorApp.lightGrey,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    width: 0.8.sw,
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: ColorApp.border,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Ubah Password",
                                          style: TypographyApp.profileItem,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: ColorApp.splash,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Bantuan",
                        style: TypographyApp.profileItemTitle,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      InkWell(
                        onTap: _sendEmail,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.email_rounded,
                              color: ColorApp.lightGrey,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              width: 0.8.sw,
                              padding: EdgeInsets.only(bottom: 16.h),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: ColorApp.border,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Kontak Kami",
                                    style: TypographyApp.profileItem,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: ColorApp.splash,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      InkWell(
                        onTap: _sendEmail,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.report_rounded,
                              color: ColorApp.lightGrey,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              width: 0.8.sw,
                              padding: EdgeInsets.only(bottom: 16.h),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: ColorApp.border,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Laporkan Masalah",
                                    style: TypographyApp.profileItem,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: ColorApp.splash,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Lainnya",
                        style: TypographyApp.profileItemTitle,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed(Routes.tnc.name);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.library_books_rounded,
                              color: ColorApp.lightGrey,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              width: 0.8.sw,
                              padding: EdgeInsets.only(bottom: 16.h),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: ColorApp.border,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Syarat & Ketentuan",
                                    style: TypographyApp.profileItem,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: ColorApp.splash,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      InkWell(
                        onTap: () {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              title: 'Apakah kamu ingin keluar dari akun ini?',
                              backgroundColor: Colors.white,
                              showCancelBtn: true,
                              cancelBtnText: 'Batal',
                              confirmBtnText: 'Keluar',
                              confirmBtnColor: ColorApp.red,
                              onConfirmBtnTap: () {
                                ref
                                    .read(profileControllerProvider.notifier)
                                    .logout();
                                ref
                                    .read(goRouterProvider)
                                    .goNamed(Routes.login.name);
                                ref
                                    .read(commonControllerProvider.notifier)
                                    .setPage(0);
                              });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.logout_rounded,
                              color: ColorApp.red,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              width: 0.8.sw,
                              padding: EdgeInsets.only(bottom: 16.h),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: ColorApp.border,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Keluar",
                                    style: TypographyApp.profileItem.copyWith(
                                      color: ColorApp.red,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: ColorApp.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _sendEmail() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'orbit.dev@gmail.com',
  );
  if (await canLaunchUrl(Uri.parse(emailLaunchUri.toString()))) {
    await launchUrl(Uri.parse(emailLaunchUri.toString()));
  } else {
    throw 'Could not launch email';
  }
}
