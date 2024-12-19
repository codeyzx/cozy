import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/custom/domain/custom_product.dart';
import 'package:chyess/src/features/custom/presentation/custom_controller.dart';
import 'package:chyess/src/features/custom/presentation/custom_state.dart';
import 'package:chyess/src/features/order/domain/customer/customer.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/routes/extras.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ConsultPage extends ConsumerWidget {
  const ConsultPage({super.key});

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
        title: Text('Konsultasi Pakaian', style: TypographyApp.searchText),
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
                    Text('Informasi Konsultasi',
                        style: TypographyApp.searchText),
                    Gap.h4,
                    Text(
                      'Tahap 1/2',
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
                      'Hal yang ingin dikonsultasikan',
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
                  controller: TextEditingController(),
                  hintText: 'Masukkan Hal yang ingin dikonsultasikan',
                  validator: validate,
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
        ref: ref,
      ),
    );
  }
}

class BottomSheetCustomWidget extends StatelessWidget {
  const BottomSheetCustomWidget({
    super.key,
    required this.state,
    required this.ref,
  });

  final CustomState state;
  final WidgetRef ref;

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

          final user =
              ref.read(commonControllerProvider).userValue.asData?.value;

          final customer = Customer(
            id: user!.id,
            name: user.name,
            email: user.email,
            phone: user.phone,
            address: user.address,
          );

          const price = 50000;

          final order = Order(
            createdAt: DateTime.now(),
            designer: state.designer,
            customer: customer,
            type: 'consultation',
            statusCustom: 'Menunggu Pembayaran',
            items: CustomProduct(
              id: '1',
              name: 'Konsultasi Pakaian',
              price: price.toDouble(),
              qty: 1,
            ),
          );

          context.pushNamed(Routes.consultConfirm.name,
              extra: Extras(datas: {ExtrasKey.order: order}));
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
