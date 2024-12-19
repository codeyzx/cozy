import 'dart:math';

import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/custom/presentation/custom_controller.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/features/order/domain/transaction/transaction.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:midtrans_sdk/midtrans_sdk.dart';

class OrderConfirmPage extends ConsumerStatefulWidget {
  const OrderConfirmPage({super.key, required this.order});

  final Order order;

  @override
  ConsumerState<OrderConfirmPage> createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends ConsumerState<OrderConfirmPage> {
  MidtransSDK? _midtrans;

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderControllerProvider);
    final controller = ref.read(orderControllerProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Detail Pesanan', style: TypographyApp.searchText),
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
                    Text('Detail Tawaran Pesanan',
                        style: TypographyApp.searchText),
                  ],
                ),
                Gap.h24,
                Text(
                  'Harga Tawaran',
                  style: TextStyle(
                    color: ColorApp.black.withOpacity(0.8),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap.h8,
                InputFormWidget(
                  controller: state.priceController,
                  hintText: '',
                  validator: validate,
                  enabled: false,
                ),
                Gap.h16,
                Text(
                  'Kuantitas',
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
                  hintText: '',
                  items: List.generate(10, (index) => index + 1)
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text('$e pcs'),
                          ))
                      .toList(),
                  value: state.qty,
                  onChanged: controller.onChangeQty,
                ),
                Gap.h16,
                Text(
                  'Harga Total',
                  style: TextStyle(
                    color: ColorApp.black.withOpacity(0.8),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap.h8,
                InputFormWidget(
                  controller: state.totalController,
                  hintText: '',
                  validator: validate,
                  enabled: false,
                ),
                Gap.h16,
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
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
          onPressed: state.loadingValue is AsyncLoading
              ? () {}
              : () async {
                  _midtrans = await MidtransSDK.init(
                    config: MidtransConfig(
                      clientKey: "SB-Mid-client-UvEFJ2HLiezSX9Hx",
                      merchantBaseUrl:
                          "https://cozy-api-alpha.vercel.app/notification_handler/",
                      colorTheme: ColorTheme(
                        colorPrimary: ColorApp.primary,
                        colorPrimaryDark: const Color(0xFF3785FC),
                        colorSecondary: const Color(0xFF29D697),
                      ),
                    ),
                  );
                  _midtrans?.setUIKitCustomSetting(
                    skipCustomerDetailsPages: true,
                    showPaymentStatus: true,
                  );

                  String chars =
                      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                  String random = List.generate(
                          15, (index) => chars[Random().nextInt(chars.length)])
                      .join();

                  // final user = ref
                  //     .read(commonControllerProvider)
                  //     .userValue
                  //     .asData
                  //     ?.value;

                  // Customer customer = Customer(
                  //   name: state.usernameController.text.toString(),
                  //   email: state.emailController.text.toString(),
                  //   phone: state.phoneController.text.toString(),
                  //   address: state.addressController.text.toString(),
                  //   id: user?.id ?? '',
                  // );

                  // CustomProduct customProduct = CustomProduct(
                  //   id: widget.product.id.toString(),
                  //   name: widget.product.name,
                  //   price: widget.product.price!.toDouble(),
                  //   color: widget.product.colors!,
                  //   size: widget.product.sizes!,
                  //   material: widget.product.materials!,
                  //   imageUrl: widget.product.imageUrl!,
                  //   qty: 1,
                  // );

                  Map<String, dynamic> body = {
                    "order_id": random,
                    "customers": {
                      // "username": state.usernameController.text.toString(),
                      // "email": state.emailController.text.toString(),
                      // "phone": state.phoneController.text.toString(),
                      "username": widget.order.customer?.name,
                      "email": widget.order.customer?.email,
                      "phone": widget.order.customer?.phone,
                    },
                    "url": "",
                    "items": [
                      {
                        // "id": "1",
                        // "price": 123450,
                        // "quantity": 2,
                        // "name": "Pakaian Kebaya Anak"
                        "id": widget.order.items?.id,
                        "price": widget.order.items?.price,
                        "quantity": state.qty,
                        "name": widget.order.items?.name,
                      }
                    ],
                  };

                  final token = await ref
                      .read(customControllerProvider.notifier)
                      .getToken(body);

                  await _midtrans?.startPaymentUiFlow(
                    token: token,
                  );

                  _midtrans!.setTransactionFinishedCallback((result) async {
                    if (!result.isTransactionCanceled) {
                      final price =
                          state.totalController.text.replaceAll('Rp', '');
                      final totalPayment =
                          double.parse(price.replaceAll('.', ''));

                      Transaction transaction = Transaction(
                        orderId: result.orderId,
                        methodPayment: result.paymentType,
                        statusPayment: result.transactionStatus?.name,
                        tokenPayment: '',
                        totalPayment: totalPayment,
                      );

                      Order order = widget.order.copyWith(
                        transaction: transaction,
                      );

                      await ref
                          .read(orderControllerProvider.notifier)
                          .addTransaction(order);

                      final user = ref
                          .read(commonControllerProvider)
                          .userValue
                          .asData
                          ?.value;

                      await ref
                          .read(orderControllerProvider.notifier)
                          .fetchOrders(user?.role ?? '', user?.id ?? '');

                      ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
                    }
                  });
                },
          child: state.loadingValue is AsyncLoading
              ? const LoadingWidget()
              : Text(
                  "Konfirmasi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
