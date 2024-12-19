import 'dart:io';

import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/common/presentation/question/question_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/shared/utils/picker.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionPage extends ConsumerWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionControllerProvider);
    final controller = ref.read(questionControllerProvider.notifier);
    return StatusBarWidget(
      brightness: Brightness.dark,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 5.h, left: 25.w, right: 25.w),
            margin: EdgeInsets.only(bottom: 150.h, top: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.black),
                  iconSize: 20,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      side: BorderSide(
                          color: const Color(0xffCCD1D6), width: 0.3.w),
                    ),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(8),
                  ),
                ),
                Gap.h12,
                Text(
                  'Informasi Kamu Sebagai Designer',
                  style: TypographyApp.onBoardTitle.copyWith(fontSize: 23.sp),
                ),
                Form(
                    key: state.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap.h28,
                        Text(
                          'Profile ',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        GestureDetector(
                          onTap: state.imageUrl == null
                              ? () async {
                                  await showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      backgroundColor: Colors.white,
                                      title: const Text(
                                        'Pilih Foto',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              try {
                                                final imageUrl =
                                                    await pickImage(
                                                        isCamera: false);
                                                if (imageUrl != null) {
                                                  controller
                                                      .setImageUrl(imageUrl);
                                                }
                                              } catch (e) {
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500),
                                                  () => showSnackBar(context,
                                                      Colors.red, e.toString()),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey[300]!),
                                                ),
                                              ),
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.image,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Dari Galeri',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              try {
                                                final imageUrl =
                                                    await pickImage(
                                                        isCamera: true);
                                                if (imageUrl != null) {
                                                  controller
                                                      .setImageUrl(imageUrl);
                                                }
                                              } catch (e) {
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500),
                                                  () => showSnackBar(context,
                                                      Colors.red, e.toString()),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Dari Kamera',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              : () {},
                          child: state.imageUrl == null
                              ? Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: Colors.grey),
                                    image: DecorationImage(
                                      image: FileImage(File(state.imageUrl!)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        Gap.h28,
                        Text(
                          'Deskripsi ',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.descriptionController,
                          hintText:
                              'Seorang desainer yang sudah berpengalaman selama 5 tahun dalam dunia fashion.',
                          keyboardType: TextInputType.text,
                          maxLines: 4,
                          validator: validate,
                        ),
                        Gap.h28,
                        Text(
                          'Nomor Telepon Aktif',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget.phone(
                          controller: state.phoneController,
                          keyboardType: TextInputType.number,
                          hintText: '8123456789',
                          prefixIcon: Icons.leaderboard,
                        ),
                        Gap.h28,
                        Text(
                          'Nama Kota Alamat',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.cityController,
                          hintText: 'Bandung',
                          keyboardType: TextInputType.text,
                          validator: validate,
                        ),
                        Gap.h24,
                        Text(
                          'Alamat Lengkap',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.addressController,
                          hintText:
                              'Jl. Jend. Sudirman No. 1, Kel. Cihapit, Kec. Bandung Wetan, Kota Bandung, Jawa Barat 40114',
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          validator: validate,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(16),
          width: 1.sw,
          height: 100.h,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: ColorApp.shadow.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ]),
          child: ButtonWidget.primary(
            text: 'Mulai Sekarang',
            isLoading: state.loadingValue is AsyncLoading,
            onTap: state.loadingValue is AsyncLoading
                ? () {}
                : () async {
                    if (!state.formKey.currentState!.validate()) {
                      return;
                    }
                    if (state.imageUrl == null) {
                      hideSnackBar(context);
                      showSnackBar(
                          context, Colors.red, 'Foto tidak boleh kosong');
                      return;
                    }
                    await controller.submit();

                    await ref
                        .read(commonControllerProvider.notifier)
                        .getProfile();

                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () => showSnackBar(
                          context, Colors.green, 'Berhasil mendaftar!'),
                    );

                    ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
                  },
          ),
        ),
      ),
    );
  }
}
