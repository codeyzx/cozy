import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/common/presentation/profile/presentation/profile_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/shared/utils/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

class ProfileEditPage extends ConsumerWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);
    final user = ref.watch(commonControllerProvider).userValue.asData?.value;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorApp.secondary,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text("Edit Profil",
            style: TextStyle(
              color: ColorApp.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              state.imageUrl == null || state.imageUrl == ''
                  ? Center(
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundImage: const AssetImage(
                            'assets/images/profile_default_img.png'),
                        backgroundColor: Colors.white,
                      ),
                    )
                  :
                  // check if state.imageUrl is contain https or not
                  state.imageUrl!.contains('https')
                      ? Center(
                          child: CachedNetworkImage(
                            imageUrl: state.imageUrl!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 50.r,
                              backgroundImage: imageProvider,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      : Center(
                          child: CircleAvatar(
                            radius: 50.r,
                            backgroundImage: Image.file(
                              File(state.imageUrl!),
                              fit: BoxFit.cover,
                            ).image,
                            backgroundColor: Colors.white,
                          ),
                        ),
              Center(
                child: TextButton(
                  onPressed: () async {
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
                                    () => showSnackBar(
                                        context, Colors.red, e.toString()),
                                  );
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]!),
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
                                    () => showSnackBar(
                                        context, Colors.red, e.toString()),
                                  );
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
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
                  },
                  child: Text(
                    "Ubah Foto",
                    style: TextStyle(
                      color: ColorApp.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Nama",
                style: TextStyle(
                  color: ColorApp.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextFormField(
                controller: state.nameController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorApp.border,
                      width: 1.w,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorApp.border,
                      width: 1.w,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: ColorApp.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Email",
                style: TextStyle(
                  color: ColorApp.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextFormField(
                enabled: false,
                controller: state.emailController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorApp.border,
                      width: 1.w,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorApp.border,
                      width: 1.w,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: ColorApp.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Visibility(
                visible: user?.role == 'designer',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nomor Telepon",
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          controller: state.phoneController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.border,
                                width: 1.w,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.border,
                                width: 1.w,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Kota Alamat",
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          controller: state.cityController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.border,
                                width: 1.w,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.border,
                                width: 1.w,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alamat Lengkap",
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          maxLines: 3,
                          controller: state.addressController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.border,
                                width: 1.w,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.border,
                                width: 1.w,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deskripsi",
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          maxLines: 3,
                          controller: state.descriptionController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.border,
                                width: 1.w,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.border,
                                width: 1.w,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150.h,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        width: 1.sw,
        height: 98.h,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: ColorApp.shadow.withOpacity(0.10),
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
          onPressed: state.loadingValue is AsyncLoading
              ? null
              : user?.role == 'designer'
                  ? () async {
                      if (state.nameController.text == state.user?.name &&
                          state.imageUrl == state.user?.photoUrl &&
                          state.phoneController.text == state.user?.phone &&
                          state.addressController.text == state.user?.address &&
                          state.cityController.text == state.user?.city &&
                          state.descriptionController.text ==
                              state.user?.description) {
                        return;
                      }

                      await controller.updateProfile();

                      ref.read(commonControllerProvider.notifier)
                        ..getProfile()
                        ..fetchDesigners();

                      Future.delayed(const Duration(seconds: 1), () {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Berhasil Mengubah Profil',
                            showCancelBtn: false,
                            barrierDismissible: false,
                            confirmBtnText: 'Kembali ke Beranda',
                            onConfirmBtnTap: () {
                              ref
                                  .read(goRouterProvider)
                                  .goNamed(Routes.botNavBar.name);
                            });
                      });
                    }
                  : () async {
                      if (state.nameController.text == state.user?.name &&
                          state.imageUrl == state.user?.photoUrl) {
                        return;
                      }

                      await controller.updateProfile();
                      await ref
                          .read(commonControllerProvider.notifier)
                          .getProfile();

                      Future.delayed(const Duration(seconds: 1), () {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Berhasil Mengubah Profil',
                            showCancelBtn: false,
                            barrierDismissible: false,
                            confirmBtnText: 'Kembali ke Beranda',
                            onConfirmBtnTap: () {
                              ref
                                  .read(goRouterProvider)
                                  .goNamed(Routes.botNavBar.name);
                            });
                      });
                    },
          child: state.loadingValue is AsyncLoading
              ? const LoadingWidget()
              : Text(
                  "Simpan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
