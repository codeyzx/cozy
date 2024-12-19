import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/custom/presentation/custom_controller.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/routes/routes.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomDetailPersonalPage extends ConsumerWidget {
  const CustomDetailPersonalPage({super.key, this.product});

  final Product? product;

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
        child: PaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h12,
                  Text('Informasi Pribadi', style: TypographyApp.searchText),
                  Gap.h4,
                  Text(
                    'Tahap 2/3',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorApp.primary,
                    ),
                  ),
                ],
              ),
              Gap.h24,
              // Text Nama*
              Row(
                children: [
                  Text(
                    'Nama',
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
              // Text(
              //   'Nama',
              //   style: TextStyle(
              //     color: ColorApp.black.withOpacity(0.8),
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              Gap.h8,
              InputFormWidget(
                controller: state.usernameController,
                hintText: 'Nama Lengkap',
                prefixSvgIcon: Assets.icons.icProfileForm,
                validator: validate,
              ),
              Gap.h16,
              // Text(
              //   'Email',
              //   style: TextStyle(
              //     color: ColorApp.black.withOpacity(0.8),
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              Row(
                children: [
                  Text(
                    'Email',
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
                controller: state.emailController,
                hintText: 'abc@gmail.com',
                prefixSvgIcon: Assets.icons.icEmail,
                validator: validateEmail,
              ),
              Gap.h16,
              // Text(
              //   'Nomor Telepon',
              //   style: TextStyle(
              //     color: ColorApp.black.withOpacity(0.8),
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              Row(
                children: [
                  Text(
                    'Nomor Telepon',
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
              InputFormWidget.phone(
                controller: state.phoneController,
                keyboardType: TextInputType.number,
                hintText: '8123456789',
                prefixIcon: Icons.leaderboard,
                // validator: controller.validateHeight,
              ),
              Gap.h16,
              // Alamat Rumah
              Row(
                children: [
                  Text(
                    'Alamat Rumah',
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
              // Text(
              //   'Alamat Rumah',
              //   style: TextStyle(
              //     color: ColorApp.black.withOpacity(0.8),
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              Gap.h8,
              InputFormWidget(
                controller: state.addressController,
                hintText: 'Jl. Jend. Sudirman No. 1',
                keyboardType: TextInputType.streetAddress,
                maxLines: 5,
              ),
              Gap.h16,
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheetCustomWidget(
        product: product,
      ),
    );
  }
}

class BottomSheetCustomWidget extends StatelessWidget {
  const BottomSheetCustomWidget({
    super.key,
    this.product,
  });

  final Product? product;

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
        onPressed: product != null
            ? () {
                context.pushNamed(Routes.productConfirmation.name,
                    extra: Extras(datas: {ExtrasKey.product: product}));
              }
            : () {
                context.pushNamed(Routes.customConfirmation.name);
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
