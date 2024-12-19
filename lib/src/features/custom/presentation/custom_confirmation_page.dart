import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/custom/domain/custom_product.dart';
import 'package:chyess/src/features/custom/presentation/custom_controller.dart';
import 'package:chyess/src/features/order/domain/customer/customer.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/shared/utils/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomConfirmationPage extends ConsumerWidget {
  const CustomConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customControllerProvider);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h12,
                  Text('Konfirmasi Custom Pakaian',
                      style: TypographyApp.searchText),
                  Gap.h4,
                  Text(
                    'Tahap 3/3',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorApp.primary,
                    ),
                  ),
                ],
              ),
              Gap.h24,
              Text(
                'Informasi Desainer',
                style: TextStyle(
                  color: ColorApp.black.withOpacity(0.8),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap.h8,
              Container(
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorApp.shadow.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    state.designer!.photoUrl == null
                        ? CircleAvatar(
                            radius: 25.r,
                            backgroundImage: Assets.images.profileDefaultImg
                                .image(
                                  width: 54.w,
                                  height: 54.h,
                                )
                                .image,
                            backgroundColor: Colors.white,
                          )
                        : CachedNetworkImage(
                            imageUrl: state.designer!.photoUrl.toString(),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 54.w,
                              height: 54.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                    Gap.w12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.designer!.name.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // 'Jakarta Utara',
                          state.designer?.city ?? '',
                          style: TextStyle(
                            color: ColorApp.black.withOpacity(0.8),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Informasi Pakaian',
                    style: TextStyle(
                      color: ColorApp.black.withOpacity(0.8),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: ColorApp.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Gap.h8,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorApp.shadow.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    state.imageUrl == null
                        ? Container(
                            height: 200.h,
                            width: 1.sw,
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
                    Gap.h16,
                    Row(
                      children: [
                        Text(
                          'Nama Pakaian:',
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap.w4,
                        SizedBox(
                          width: 180.w,
                          child: Text(
                            // 'Kemeja Batik',
                            state.nameController.text.toString(),
                            style: TextStyle(
                              color: ColorApp.black.withOpacity(0.8),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap.h8,
                    Row(
                      children: [
                        Text(
                          'Bahan:',
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          // 'Bahan Kain',
                          state.material ?? 'Tidak diisi',
                          style: TextStyle(
                            color: ColorApp.black.withOpacity(0.8),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Gap.h8,
                    Row(
                      children: [
                        Text(
                          'Ukuran:',
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          // 'L',
                          state.size.toString(),
                          style: TextStyle(
                            color: ColorApp.black.withOpacity(0.8),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Gap.h8,
                    Row(
                      children: [
                        Text(
                          'Warna:',
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          // 'Merah',
                          state.colorController.text.isEmpty
                              ? 'Tidak diisi'
                              : state.colorController.text.toString(),
                          style: TextStyle(
                            color: ColorApp.black.withOpacity(0.8),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Informasi Pribadi',
                    style: TextStyle(
                      color: ColorApp.black.withOpacity(0.8),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: ColorApp.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Gap.h8,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorApp.shadow.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama:',
                          style: TextStyle(
                            color: ColorApp.black.withOpacity(0.8),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          // 'Ahmad Joni',
                          state.usernameController.text.toString(),
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gap.h8,
//                 email
// telp
// alamat
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email:',
                          style: TextStyle(
                            color: ColorApp.black.withOpacity(0.8),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          // 'ahmadjoni@gmail.com',
                          state.emailController.text.toString(),
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gap.h8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Telepon:',
                          style: TextStyle(
                            color: ColorApp.black.withOpacity(0.8),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          // '08123456789',
                          '0${state.phoneController.text}',
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gap.h8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alamat:',
                          style: TextStyle(
                            color: ColorApp.black.withOpacity(0.8),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          // 'Jl. Kebon Jeruk No. 12, Jakarta Barat',
                          state.addressController.text.toString(),
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: const BottomSheetCustomWidget(),
    );
  }
}

class BottomSheetCustomWidget extends ConsumerWidget {
  const BottomSheetCustomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customControllerProvider);
    final user = ref.read(commonControllerProvider).userValue.asData?.value;
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
        onPressed: () async {
          final imageUrl = state.imageUrl != null
              ? state.imageUrl!.contains('https')
                  ? state.imageUrl!
                  : await uploadImages(state.imageUrl!, path: 'custom')
              : '';
          Customer customer = Customer(
            name: state.usernameController.text.toString(),
            email: state.emailController.text.toString(),
            phone: state.phoneController.text.toString(),
            address: state.addressController.text.toString(),
            id: user?.id ?? '',
          );

          CustomProduct customProduct = CustomProduct(
            name: state.nameController.text.toString(),
            material: state.material,
            size: state.size.toString(),
            color: state.colorController.text,
            imageUrl: imageUrl,
            qty: 1,
          );

          Order order = Order(
            createdAt: DateTime.now(),
            customer: customer,
            designer: state.designer,
            items: customProduct,
            statusCustom: 'Menunggu Konfirmasi',
            type: 'custom',
          );

          await ref.read(orderControllerProvider.notifier).addOrder(order);
          await ref
              .read(orderControllerProvider.notifier)
              .fetchOrders(user?.role ?? '', user?.id ?? '');
          Future.delayed(const Duration(seconds: 1), () {
            showSnackBar(context, ColorApp.green,
                'Berhasil Membuat Pesanan Pakaian Custom!');
          });
          ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
        },
        child: Text(
          "Konfirmasi",
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
