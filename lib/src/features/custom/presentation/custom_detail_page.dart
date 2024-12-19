import 'dart:io';

import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/custom/presentation/custom_controller.dart';
import 'package:chyess/src/features/custom/presentation/custom_state.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/shared/utils/picker.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomDetailPage extends ConsumerWidget {
  const CustomDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customControllerProvider);
    final controller = ref.read(customControllerProvider.notifier);
    final designers =
        ref.read(commonControllerProvider).designers.asData?.value;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Custom Pakaian', style: TypographyApp.searchText),
        centerTitle: true,
        leadingWidth: 78.w,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          iconSize: 20,
          padding: const EdgeInsets.all(8.0),
          color: Colors.black,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(color: ColorApp.border, width: 0.3.w),
            ),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            bottom: 120.h,
          ),
          child: Form(
            key: state.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap.h12,
                    Text('Informasi Pakaian', style: TypographyApp.searchText),
                    Gap.h4,
                    Text(
                      'Tahap 1/3',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorApp.primary,
                      ),
                    ),
                  ],
                ),
                Gap.h24,
                Row(
                  children: [
                    Text(
                      'Nama Custom Pakaian',
                      style: TextStyle(
                        color: ColorApp.black.withOpacity(0.8),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        color: ColorApp.red,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Gap.h8,
                InputFormWidget(
                  controller: state.nameController,
                  hintText: 'Pakaian Lebaran',
                  validator: validate,
                ),
                Gap.h16,
                Row(
                  children: [
                    Text(
                      'Desain',
                      style: TextStyle(
                        color: ColorApp.black.withOpacity(0.8),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        color: ColorApp.red,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Gap.h8,
                GestureDetector(
                  onTap: state.imageUrl == null
                      ? () async {
                          await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
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
                                            await pickImage(isCamera: false);
                                        if (imageUrl != null) {
                                          controller.setImageUrl(imageUrl);
                                        }
                                      } catch (e) {
                                        Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () => showSnackBar(context,
                                              Colors.red, e.toString()),
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
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
                                              fontWeight: FontWeight.w400,
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
                                            await pickImage(isCamera: true);
                                        if (imageUrl != null) {
                                          controller.setImageUrl(imageUrl);
                                        }
                                      } catch (e) {
                                        Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () => showSnackBar(context,
                                              Colors.red, e.toString()),
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
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
                                              fontWeight: FontWeight.w400,
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
                Gap.h16,
                Text(
                  'Bahan',
                  style: TextStyle(
                    color: ColorApp.black.withOpacity(0.8),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap.h8,
                DropdownWidget(
                  style: TypographyApp.loginOffInput
                      .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  hintText: 'Bahan Kain',
                  items: const [
                    DropdownMenuItem(
                      value: 'Katun',
                      child: Text('Katun'),
                    ),
                    DropdownMenuItem(
                      value: 'Sutra',
                      child: Text('Sutra'),
                    ),
                    DropdownMenuItem(
                      value: 'Denim',
                      child: Text('Denim'),
                    ),
                    DropdownMenuItem(
                      value: 'Wol',
                      child: Text('Wol'),
                    ),
                    DropdownMenuItem(
                      value: 'Polyester',
                      child: Text('Polyester'),
                    ),
                  ],
                  value: state.material,
                  onChanged: controller.setMaterial,
                ),
                Gap.h16,
                Row(
                  children: [
                    Text(
                      'Ukuran',
                      style: TextStyle(
                        color: ColorApp.black.withOpacity(0.8),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        color: ColorApp.red,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Gap.h8,
                DropdownWidget(
                  style: TypographyApp.loginOffInput
                      .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  hintText: 'Pilih Ukuran',
                  items: const [
                    DropdownMenuItem(
                      value: 'S',
                      child: Text('S'),
                    ),
                    DropdownMenuItem(
                      value: 'M',
                      child: Text('M'),
                    ),
                    DropdownMenuItem(
                      value: 'L',
                      child: Text('L'),
                    ),
                    DropdownMenuItem(
                      value: 'XL',
                      child: Text('XL'),
                    ),
                    DropdownMenuItem(
                      value: 'XXL',
                      child: Text('XXL'),
                    ),
                    DropdownMenuItem(
                      value: '3XL',
                      child: Text('3XL'),
                    ),
                  ],
                  value: state.size,
                  onChanged: controller.setSize,
                ),
                Gap.h16,
                Text(
                  'Warna',
                  style: TextStyle(
                    color: ColorApp.black.withOpacity(0.8),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap.h8,
                InputFormWidget(
                  controller: state.colorController,
                  hintText: 'Warna Pakaian',
                ),
                Gap.h16,
                Row(
                  children: [
                    Text(
                      'Desainer',
                      style: TextStyle(
                        color: ColorApp.black.withOpacity(0.8),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        color: ColorApp.red,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Gap.h8,
                DropdownWidget(
                  style: TypographyApp.loginOffInput
                      .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  hintText: 'Pilih Desainer',
                  items: designers!
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name!),
                        ),
                      )
                      .toList(),
                  value: state.designer,
                  onChanged: controller.setDesigner,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BottomSheetCustomWidget(
        state: state,
      ),
    );
  }
}

class BottomSheetCustomWidget extends StatelessWidget {
  const BottomSheetCustomWidget({
    super.key,
    required this.state,
  });

  final CustomState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 1.sw,
      height: 98.h,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: ColorApp.shadow.withOpacity(0.5),
          blurRadius: 5,
          offset: const Offset(0, -3),
        ),
      ]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorApp.primary,
          padding: EdgeInsets.symmetric(horizontal: 87.w, vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: () {
          if (!state.formKey.currentState!.validate()) {
            return;
          }
          context.pushNamed(Routes.customDetailPersonal.name);
        },
        child: Text(
          "Lanjutkan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
