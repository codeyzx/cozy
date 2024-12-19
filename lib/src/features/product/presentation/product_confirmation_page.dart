import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/custom/domain/custom_product.dart';
import 'package:chyess/src/features/custom/presentation/custom_controller.dart';
import 'package:chyess/src/features/order/domain/customer/customer.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/features/order/domain/transaction/transaction.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:midtrans_sdk/midtrans_sdk.dart';

class ProductConfirmationPage extends ConsumerStatefulWidget {
  const ProductConfirmationPage({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<ProductConfirmationPage> createState() =>
      _ProductConfirmationPageState();
}

class _ProductConfirmationPageState
    extends ConsumerState<ProductConfirmationPage> {
  MidtransSDK? _midtrans;

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Pembelian Pakaian', style: TypographyApp.searchText),
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
                  Text('Konfirmasi Pembelian Pakaian',
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
                    CachedNetworkImage(
                      // imageUrl: 'https://www.picsum.photos/250/250?image=9',
                      imageUrl: widget.product.designer?.photoUrl ?? '',
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
                          widget.product.designer?.name ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // 'Jakarta Utara',
                          widget.product.designer?.city ?? 'Designer Pakaian',
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
                    widget.product.imageUrl == null ||
                            widget.product.imageUrl == ''
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
                                image: NetworkImage(
                                  widget.product.imageUrl == null ||
                                          widget.product.imageUrl == ''
                                      ? 'https://picsum.photos/200/600'
                                      : widget.product.imageUrl!,
                                ),
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
                            widget.product.name.toString(),
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
                          widget.product.materials ?? 'Tidak diisi',
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
                          widget.product.sizes ?? 'Tidak diisi',
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
                          widget.product.colors ?? 'Tidak diisi',
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

                  final user = ref
                      .read(commonControllerProvider)
                      .userValue
                      .asData
                      ?.value;

                  Customer customer = Customer(
                    name: state.usernameController.text.toString(),
                    email: state.emailController.text.toString(),
                    phone: state.phoneController.text.toString(),
                    address: state.addressController.text.toString(),
                    id: user?.id ?? '',
                  );

                  CustomProduct customProduct = CustomProduct(
                    id: widget.product.id.toString(),
                    name: widget.product.name,
                    price: widget.product.price!.toDouble(),
                    color: widget.product.colors!,
                    size: widget.product.sizes!,
                    material: widget.product.materials!,
                    imageUrl: widget.product.imageUrl!,
                    qty: 1,
                  );

                  Map<String, dynamic> body = {
                    "order_id": random,
                    "customers": {
                      "username": state.usernameController.text.toString(),
                      "email": state.emailController.text.toString(),
                      "phone": state.phoneController.text.toString(),
                    },
                    "url": "",
                    "items": [
                      {
                        // "id": "1",
                        // "price": 123450,
                        // "quantity": 2,
                        // "name": "Pakaian Kebaya Anak"
                        "id": widget.product.id,
                        "price": widget.product.price,
                        "quantity": 1,
                        "name": widget.product.name,
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
                      Transaction transaction = Transaction(
                        orderId: result.orderId,
                        methodPayment: result.paymentType,
                        statusPayment: result.transactionStatus?.name,
                        tokenPayment: '',
                        totalPayment: widget.product.price!.toDouble(),
                      );

                      Order order = Order(
                        createdAt: DateTime.now(),
                        customer: customer,
                        designer: widget.product.designer,
                        items: customProduct,
                        statusCustom: 'Menunggu Pembayaran',
                        transaction: transaction,
                        type: 'product',
                      );

                      await ref
                          .read(orderControllerProvider.notifier)
                          .addOrder(order);

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
