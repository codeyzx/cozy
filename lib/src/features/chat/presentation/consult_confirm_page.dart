import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/custom/domain/custom_product.dart';
import 'package:chyess/src/features/custom/presentation/custom_controller.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/features/order/domain/transaction/transaction.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/shared/extensions/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:midtrans_sdk/midtrans_sdk.dart';

class ConsultConfirmPage extends ConsumerStatefulWidget {
  const ConsultConfirmPage({super.key, required this.order});

  final Order order;

  @override
  ConsumerState<ConsultConfirmPage> createState() => ConsultConfirmPageState();
}

class ConsultConfirmPageState extends ConsumerState<ConsultConfirmPage> {
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
        title: Text('Detail Konsultasi', style: TypographyApp.searchText),
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
                  Text('Konfirmasi Konsultasi',
                      style: TypographyApp.searchText),
                  Gap.h4,
                  Text(
                    'Tahap 2/2',
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
                    widget.order.designer?.photoUrl == '' ||
                            widget.order.designer?.photoUrl == null
                        ? Assets.images.cozyLogo.image(
                            width: 54.w,
                            height: 54.h,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl:
                                widget.order.designer!.photoUrl.toString(),
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
                          // 'Ahmad Joni',
                          widget.order.designer?.name ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // 'Jakarta Utara',
                          widget.order.designer?.city ?? 'Designer Pakaian',
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
                    'Informasi Konsultasi',
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
                    Row(
                      children: [
                        Text(
                          'Konsultasi dengan:',
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap.w4,
                        SizedBox(
                          width: 150.w,
                          child: Text(
                            widget.order.designer?.name ?? '',
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
                          'Tanggal Konsultasi:',
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          DateTime.now().dateWithDayMonthYear,
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
                          'Durasi Konsultasi:',
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap.w4,
                        Text(
                          '30 Menit',
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
                          widget.order.customer?.name ?? '',
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
                          widget.order.customer?.email ?? '',
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
                      "username": widget.order.customer?.name,
                      "email": widget.order.customer?.email,
                      "phone": widget.order.customer?.phone,
                    },
                    "url": "",
                    "items": [
                      {
                        "id": widget.order.items?.id,
                        "price": widget.order.items?.price,
                        "quantity": 1,
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
                  const price = 50000;

                  _midtrans!.setTransactionFinishedCallback((result) async {
                    if (!result.isTransactionCanceled) {
                      Transaction transaction = Transaction(
                        orderId: result.orderId,
                        methodPayment: result.paymentType,
                        statusPayment: result.transactionStatus?.name,
                        tokenPayment: '',
                        totalPayment: price.toDouble(),
                      );

                      CustomProduct customProduct = CustomProduct(
                        id: widget.order.items?.id.toString(),
                        name: widget.order.items?.name,
                        price: widget.order.items?.price!.toDouble(),
                        qty: 1,
                        createdAt: DateTime.now(),
                      );

                      Order order = widget.order.copyWith(
                        transaction: transaction,
                        items: customProduct,
                      );

                      await ref
                          .read(orderControllerProvider.notifier)
                          .addOrder(order);

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
