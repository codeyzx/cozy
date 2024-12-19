import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/chat/presentation/chat_controller.dart';
import 'package:chyess/src/features/chat/presentation/chat_detail_page.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/features/order/presentation/order_state.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/routes/extras.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

class OrderDetailPage extends ConsumerWidget {
  const OrderDetailPage({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderControllerProvider);
    final controller = ref.read(orderControllerProvider.notifier);
    final commonController = ref.read(commonControllerProvider);
    final user = commonController.userValue.asData?.value;
    return StatusBarWidget(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Detail Pesanan', style: TypographyApp.searchText),
            centerTitle: true,
            leadingWidth: 78.w,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:
                  const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              iconSize: 20,
              padding: const EdgeInsets.all(8.0),
              color: Colors.black,
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  side:
                      BorderSide(color: const Color(0xFFCCD1D6), width: 0.3.w),
                ),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
          body: order.type == 'product'
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 8.h,
                      bottom: 120.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle('Informasi Pesanan'),
                        Container(
                          width: 1.sw,
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: NetworkImage(
                                  order.items!.imageUrl.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        _buildDetailRow('Nama', order.items!.name.toString()),
                        Visibility(
                            visible: order.items!.material != null &&
                                order.items!.material!.isNotEmpty,
                            child: _buildDetailRow(
                                'Bahan', order.items!.material.toString())),
                        _buildDetailRow('Ukuran', order.items!.size.toString()),
                        Visibility(
                            visible: order.items!.color != null &&
                                order.items!.color!.isNotEmpty,
                            child: _buildDetailRow(
                                'Warna', order.items!.color.toString())),
                        _buildDetailRow('Jumlah', order.items!.qty.toString()),
                        order.items!.price == null
                            ? const SizedBox.shrink()
                            : _buildDetailRow(
                                'Harga Satuan', order.items!.price!.currency),
                        _buildLine(),
                        Visibility(
                          visible: ref
                                  .read(commonControllerProvider)
                                  .userValue
                                  .asData
                                  ?.value
                                  .role !=
                              'designer',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap.h24,
                              _buildTitle('Informasi Desainer'),
                              _buildDetailRow(
                                  'Nama', order.designer!.name.toString()),
                              _buildDetailRow(
                                  'Email', order.designer!.email.toString()),
                              _buildDetailRow(
                                  'Nomor Telepon', '0${order.designer!.phone}'),
                              _buildDetailRow(
                                  'Alamat', order.designer!.address.toString()),
                              _buildDetailRow(
                                  'Kota', order.designer!.city.toString()),
                              _buildLine(),
                            ],
                          ),
                        ),
                        Gap.h24,
                        _buildTitle('Informasi Pelanggan'),
                        _buildDetailRow('Nama', order.customer!.name!),
                        _buildDetailRow('Email', order.customer!.email!),
                        _buildDetailRow(
                            'Nomor Telepon', '0${order.customer!.phone!}'),
                        _buildDetailRow('Alamat', order.customer!.address!),
                        _buildLine(),
                        Gap.h24,
                        Visibility(
                          visible: order.transaction?.methodPayment != null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTitle('Detail Pembayaran'),
                              // _buildDetailRow(
                              //     'Metode Pembayaran', 'BCA Virtual Account'),
                              _buildDetailRow('Nomor Virtual Account',
                                  order.transaction!.methodPayment ?? ''),
                              // _buildDetailRow('Nomor Virtual Account', '1234567890'),
                              order.transaction!.tokenPayment == null ||
                                      order.transaction!.tokenPayment!.isEmpty
                                  ? const SizedBox.shrink()
                                  : _buildDetailRow(
                                      'Token Pembayaran',
                                      order.transaction!.tokenPayment!,
                                    ),
                              _buildLine(),
                              Gap.h40,
                              _buildLine(),
                              // _buildDetailRow('Total Biaya', 'Rp56.000',
                              //     isLast: true),
                              _buildDetailRow('Total Biaya',
                                  order.transaction!.totalPayment!.currency,
                                  isLast: true),
                              _buildLine(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : order.type == 'consultation'
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 8.h,
                          bottom: 120.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle('Konsultasi Pakaian'),
                            _buildDetailRow('Konsultasi dengan',
                                order.designer!.name.toString()),
                            _buildDetailRow('Tanggal Konsultasi',
                                order.createdAt!.dateWithDayMonthYear),
                            _buildDetailRow('Durasi Konsultasi', '30 Menit'),
                            order.items?.createdAt == null
                                ? const SizedBox.shrink()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildDetailRow('Mulai Konsultasi',
                                          '${order.createdAt!.hourWithMinute} WIB'),
                                      _buildDetailRow('Selesai Konsultasi',
                                          '${order.createdAt!.add(const Duration(minutes: 30)).hourWithMinute} WIB'),
                                    ],
                                  ),
                            _buildLine(),
                            Visibility(
                              visible: ref
                                      .read(commonControllerProvider)
                                      .userValue
                                      .asData
                                      ?.value
                                      .role !=
                                  'designer',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap.h24,
                                  _buildTitle('Informasi Desainer'),
                                  _buildDetailRow(
                                      'Nama', order.designer!.name.toString()),
                                  _buildDetailRow('Email',
                                      order.designer!.email.toString()),
                                  _buildDetailRow('Nomor Telepon',
                                      '0${order.designer!.phone}'),
                                  _buildDetailRow('Alamat',
                                      order.designer!.address.toString()),
                                  _buildDetailRow(
                                      'Kota', order.designer!.city.toString()),
                                  _buildLine(),
                                ],
                              ),
                            ),
                            Gap.h24,
                            _buildTitle('Informasi Pelanggan'),
                            _buildDetailRow('Nama', order.customer!.name!),
                            _buildDetailRow('Email', order.customer!.email!),
                            _buildLine(),
                            Gap.h24,
                            order.transaction?.methodPayment == null ||
                                    order.transaction?.methodPayment == ''
                                ? const SizedBox.shrink()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildTitle('Detail Pembayaran'),
                                      // _buildDetailRow(
                                      //     'Metode Pembayaran', 'BCA Virtual Account'),
                                      _buildDetailRow(
                                          'Metode Pembayaran',
                                          order.transaction!.methodPayment ??
                                              ''),
                                      // _buildDetailRow('Nomor Virtual Account', '1234567890'),
                                      order.transaction!.tokenPayment == null ||
                                              order.transaction!.tokenPayment!
                                                  .isEmpty
                                          ? const SizedBox.shrink()
                                          : _buildDetailRow(
                                              'Token Pembayaran',
                                              order.transaction!.tokenPayment!,
                                            ),
                                      _buildLine(),
                                      Gap.h40,
                                      _buildLine(),
                                      // _buildDetailRow('Total Biaya', 'Rp56.000',
                                      //     isLast: true),
                                      _buildDetailRow(
                                          'Total Biaya',
                                          order.transaction!.totalPayment!
                                              .currency,
                                          isLast: true),
                                      _buildLine(),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 8.h,
                          bottom: 120.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle('Pesanan Custom'),
                            Container(
                              width: 1.sw,
                              height: 200.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      order.items!.imageUrl.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            _buildDetailRow(
                                'Nama', order.items!.name.toString()),
                            Visibility(
                                visible: order.items!.material != null &&
                                    order.items!.material!.isNotEmpty,
                                child: _buildDetailRow(
                                    'Bahan', order.items!.material.toString())),
                            _buildDetailRow(
                                'Ukuran', order.items!.size.toString()),
                            Visibility(
                                visible: order.items!.color != null &&
                                    order.items!.color!.isNotEmpty,
                                child: _buildDetailRow(
                                    'Warna', order.items!.color.toString())),
                            _buildDetailRow(
                                'Jumlah', order.items!.qty.toString()),
                            order.items!.price == null
                                ? const SizedBox.shrink()
                                : _buildDetailRow('Harga Satuan',
                                    order.items!.price!.currency),
                            _buildLine(),
                            Visibility(
                              visible: ref
                                      .read(commonControllerProvider)
                                      .userValue
                                      .asData
                                      ?.value
                                      .role !=
                                  'designer',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap.h24,
                                  _buildTitle('Informasi Desainer'),
                                  _buildDetailRow(
                                      'Nama', order.designer!.name.toString()),
                                  _buildDetailRow('Email',
                                      order.designer!.email.toString()),
                                  _buildDetailRow('Nomor Telepon',
                                      '0${order.designer!.phone}'),
                                  _buildDetailRow('Alamat',
                                      order.designer!.address.toString()),
                                  _buildDetailRow(
                                      'Kota', order.designer!.city.toString()),
                                  _buildLine(),
                                ],
                              ),
                            ),
                            Gap.h24,
                            _buildTitle('Informasi Pelanggan'),
                            _buildDetailRow('Nama', order.customer!.name!),
                            _buildDetailRow('Email', order.customer!.email!),
                            _buildDetailRow(
                                'Nomor Telepon', '0${order.customer!.phone!}'),
                            _buildDetailRow('Alamat', order.customer!.address!),
                            _buildLine(),
                            Gap.h24,
                            order.transaction?.methodPayment == null ||
                                    order.transaction?.methodPayment == ''
                                ? const SizedBox.shrink()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildTitle('Detail Pembayaran'),
                                      // _buildDetailRow(
                                      //     'Metode Pembayaran', 'BCA Virtual Account'),
                                      _buildDetailRow(
                                          'Nomor Virtual Account',
                                          order.transaction!.methodPayment ??
                                              ''),
                                      // _buildDetailRow('Nomor Virtual Account', '1234567890'),
                                      order.transaction!.tokenPayment == null ||
                                              order.transaction!.tokenPayment!
                                                  .isEmpty
                                          ? const SizedBox.shrink()
                                          : _buildDetailRow(
                                              'Token Pembayaran',
                                              order.transaction!.tokenPayment!,
                                            ),
                                      _buildLine(),
                                      Gap.h40,
                                      _buildLine(),
                                      // _buildDetailRow('Total Biaya', 'Rp56.000',
                                      //     isLast: true),
                                      _buildDetailRow(
                                          'Total Biaya',
                                          order.transaction!.totalPayment!
                                              .currency,
                                          isLast: true),
                                      _buildLine(),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
          bottomSheet: user?.role == 'user'
              ? BottomSheetUser(
                  order: order, state: state, controller: controller, ref: ref)
              : BottomSheetDesigner(
                  order: order,
                  state: state,
                  controller: controller,
                  ref: ref)),
    );
  }

  Widget _buildLine() {
    return Container(height: 1.h, color: Colors.grey[300]);
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isBold = false, bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isLast
                  ? TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)
                  : TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp)),
          label == 'Alamat'
              ? SizedBox(
                  width: 250.w,
                  child: Text(
                    value,
                    textDirection: TextDirection.rtl,
                    style: isLast
                        ? TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          )
                        : TextStyle(
                            fontWeight:
                                isBold ? FontWeight.bold : FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                  ),
                )
              : Text(
                  value,
                  style: isLast
                      ? TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        )
                      : TextStyle(
                          fontWeight:
                              isBold ? FontWeight.bold : FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                ),
        ],
      ),
    );
  }
}

class BottomSheetDesigner extends StatelessWidget {
  const BottomSheetDesigner({
    super.key,
    required this.order,
    required this.state,
    required this.controller,
    required this.ref,
  });

  final Order order;
  final OrderState state;
  final OrderController controller;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return order.type == 'custom'
        ? order.statusCustom == 'Diterima' ||
                order.statusCustom == 'Dikirim' ||
                order.statusCustom == 'Selesai' ||
                order.statusCustom == 'Gagal' ||
                order.statusCustom == 'Dibatalkan'
            ? const SizedBox.shrink()
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                width: 1.sw,
                height: order.statusCustom == 'Diproses' ? 80.h : 98.h,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: ColorApp.shadow.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ]),
                child: order.statusCustom == 'Diproses'
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: SizedBox(
                          width: 190.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: order.statusCustom ==
                                    'Menunggu Konfirmasi'
                                ? () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 16.h),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30.r),
                                                topRight: Radius.circular(30.r),
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Gap.h20,
                                                  Center(
                                                    child: Container(
                                                      width: 50.w,
                                                      height: 4.h,
                                                      decoration: BoxDecoration(
                                                        color: ColorApp.grey
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                      ),
                                                    ),
                                                  ),
                                                  Gap.h20,
                                                  Text(
                                                    'Konfirmasi Pesanan',
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Gap.h24,
                                                  Text(
                                                    'Berikan harga untuk pesanan pelanggan',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Gap.h8,
                                                  TextFormField(
                                                    controller:
                                                        state.priceController,
                                                    autofocus: true,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Harga tidak boleh kosong';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Masukkan harga',
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.r),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Gap.h24,
                                                  SizedBox(
                                                    width: 1.sw,
                                                    height: 60.h,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        controller.confirmOrder(
                                                            int.parse(state
                                                                .priceController
                                                                .text),
                                                            order.id!);
                                                        QuickAlert.show(
                                                            context: context,
                                                            type: QuickAlertType
                                                                .success,
                                                            title: 'Berhasil',
                                                            showCancelBtn:
                                                                false,
                                                            barrierDismissible:
                                                                false,
                                                            confirmBtnText:
                                                                'Kembali ke Beranda',
                                                            onConfirmBtnTap:
                                                                () {
                                                              final user = ref
                                                                  .read(
                                                                      commonControllerProvider)
                                                                  .userValue
                                                                  .asData
                                                                  ?.value;
                                                              controller
                                                                  .fetchOrders(
                                                                user?.role ??
                                                                    '',
                                                                user?.id ?? '',
                                                              );
                                                              ref
                                                                  .read(commonControllerProvider
                                                                      .notifier)
                                                                  .setPage(0);
                                                              context.goNamed(
                                                                  Routes
                                                                      .botNavBar
                                                                      .name);
                                                            });
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorApp.primary,
                                                      ),
                                                      child: Text(
                                                        'Terima Pesanan',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                : order.statusCustom == 'Diproses'
                                    ? () {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.confirm,
                                            title:
                                                'Apakah pesanan sudah dikirim?',
                                            text:
                                                'Pastikan telah menghubungi pelanggan',
                                            backgroundColor: Colors.white,
                                            showCancelBtn: true,
                                            cancelBtnText: 'Tidak',
                                            confirmBtnText: 'Sudah',
                                            confirmBtnColor: ColorApp.green,
                                            onConfirmBtnTap: () {
                                              controller.confirmSendOrder(
                                                  order.id ?? '');
                                              controller.fetchOrders('designer',
                                                  order.designer?.id ?? '');
                                              context
                                                ..pop()
                                                ..pop();
                                            });
                                      }
                                    : () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  order.statusCustom == 'Menunggu Konfirmasi'
                                      ? ColorApp.primary
                                      : order.statusCustom == 'Diproses'
                                          ? const Color(0xFFAB47BC)
                                          : ColorApp.red,
                            ),
                            child: Text(
                              order.statusCustom == 'Menunggu Konfirmasi'
                                  ? 'Terima Pesanan'
                                  : order.statusCustom == 'Diproses'
                                      ? 'Kirim Pesanan'
                                      : 'Detail',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: SizedBox(
                              width: 140.w,
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed: () async {
                                  QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.confirm,
                                      title:
                                          'Yakin ingin membatalkan pesanan ini?',
                                      backgroundColor: Colors.white,
                                      showCancelBtn: true,
                                      cancelBtnText: 'Tidak',
                                      confirmBtnText: 'Iya',
                                      confirmBtnColor: ColorApp.red,
                                      onConfirmBtnTap: () {
                                        controller.cancelOrder(order.id ?? '');
                                        controller.fetchOrders('designer',
                                            order.designer?.id ?? '');
                                        ref
                                            .read(goRouterProvider)
                                            .goNamed(Routes.botNavBar.name);
                                        ref
                                            .read(commonControllerProvider
                                                .notifier)
                                            .setPage(0);
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: ColorApp.red,
                                  ),
                                ),
                                child: Text(
                                  order.statusCustom == 'Menunggu Konfirmasi'
                                      ? 'Tolak'
                                      : 'Batalkan',
                                  style: TextStyle(
                                    color: order.statusCustom ==
                                            'Menunggu Konfirmasi'
                                        ? ColorApp.red
                                        : Colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: SizedBox(
                              width: 190.w,
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed: order.statusCustom ==
                                        'Menunggu Konfirmasi'
                                    ? () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 16.h),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30.r),
                                                    topRight:
                                                        Radius.circular(30.r),
                                                  ),
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Gap.h20,
                                                      Center(
                                                        child: Container(
                                                          width: 50.w,
                                                          height: 4.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorApp.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                        ),
                                                      ),
                                                      Gap.h20,
                                                      Text(
                                                        'Konfirmasi Pesanan',
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Gap.h24,
                                                      Text(
                                                        'Berikan harga untuk pesanan pelanggan',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Gap.h8,
                                                      TextFormField(
                                                        controller: state
                                                            .priceController,
                                                        autofocus: true,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Harga tidak boleh kosong';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Masukkan harga',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.r),
                                                            borderSide:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Gap.h24,
                                                      SizedBox(
                                                        width: 1.sw,
                                                        height: 60.h,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            controller.confirmOrder(
                                                                int.parse(state
                                                                    .priceController
                                                                    .text),
                                                                order.id!);
                                                            QuickAlert.show(
                                                                context:
                                                                    context,
                                                                type:
                                                                    QuickAlertType
                                                                        .success,
                                                                title:
                                                                    'Berhasil',
                                                                showCancelBtn:
                                                                    false,
                                                                barrierDismissible:
                                                                    false,
                                                                confirmBtnText:
                                                                    'Kembali ke Beranda',
                                                                onConfirmBtnTap:
                                                                    () {
                                                                  final user = ref
                                                                      .read(
                                                                          commonControllerProvider)
                                                                      .userValue
                                                                      .asData
                                                                      ?.value;
                                                                  controller
                                                                      .fetchOrders(
                                                                    user?.role ??
                                                                        '',
                                                                    user?.id ??
                                                                        '',
                                                                  );
                                                                  ref
                                                                      .read(commonControllerProvider
                                                                          .notifier)
                                                                      .setPage(
                                                                          0);
                                                                  context.goNamed(
                                                                      Routes
                                                                          .botNavBar
                                                                          .name);
                                                                });
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                ColorApp
                                                                    .primary,
                                                          ),
                                                          child: Text(
                                                            'Terima Pesanan',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    : () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: order.statusCustom ==
                                          'Menunggu Konfirmasi'
                                      ? ColorApp.primary
                                      : order.statusCustom == 'Diproses'
                                          ? const Color(0xFFAB47BC)
                                          : ColorApp.red,
                                ),
                                child: Text(
                                  order.statusCustom == 'Menunggu Konfirmasi'
                                      ? 'Terima Pesanan'
                                      : order.statusCustom == 'Diproses'
                                          ? 'Kirim Pesanan'
                                          : 'Detail',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              )
        : order.statusCustom == 'Diterima' ||
                order.statusCustom == 'Dikirim' ||
                order.statusCustom == 'Selesai' ||
                order.statusCustom == 'Gagal' ||
                order.statusCustom == 'Dibatalkan'
            ? const SizedBox.shrink()
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                width: 1.sw,
                height: 80.h,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: ColorApp.primary.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: SizedBox(
                    width: 190.w,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: order.statusCustom == 'Diproses'
                          ? () async {
                              final String designerId =
                                  order.customer!.id.toString();
                              final check = await ref
                                  .read(chatControllerProvider.notifier)
                                  .checkChat(
                                      usersId: ref
                                          .read(
                                              commonControllerProvider.notifier)
                                          .getUid(),
                                      contactId: designerId);
                              if (check) {
                                final messagesId = await ref
                                    .read(chatControllerProvider.notifier)
                                    .getMessagesId(
                                        usersId: ref
                                            .read(commonControllerProvider
                                                .notifier)
                                            .getUid(),
                                        contactId: designerId);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatDetailPage(
                                          usersId: designerId,
                                          messagesId: messagesId),
                                    ));
                              } else {
                                await ref
                                    .read(chatControllerProvider.notifier)
                                    .createChat(
                                      usersId: ref
                                          .read(
                                              commonControllerProvider.notifier)
                                          .getUid(),
                                      contactId: designerId,
                                    );

                                final messagesId = await ref
                                    .read(chatControllerProvider.notifier)
                                    .getMessagesId(
                                        usersId: ref
                                            .read(commonControllerProvider
                                                .notifier)
                                            .getUid(),
                                        contactId: designerId);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatDetailPage(
                                          usersId: designerId,
                                          messagesId: messagesId),
                                    ));
                              }
                            }
                          : () {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  title: 'Apakah pesanan sudah dikirim?',
                                  text: 'Pastikan telah menghubungi pelanggan',
                                  backgroundColor: Colors.white,
                                  showCancelBtn: true,
                                  cancelBtnText: 'Tidak',
                                  confirmBtnText: 'Sudah',
                                  confirmBtnColor: ColorApp.green,
                                  onConfirmBtnTap: () {
                                    controller.confirmSendOrder(order.id ?? '');
                                    controller.fetchOrders(
                                        'designer', order.designer?.id ?? '');
                                    context
                                      ..pop()
                                      ..pop();
                                  });
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.primary),
                      child: Text(
                        // 'Kirim Pesanan',
                        order.statusCustom == 'Diproses'
                            ? 'Chat Sekarang'
                            : 'Kirim Pesanan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ));
  }
}

class BottomSheetUser extends StatelessWidget {
  const BottomSheetUser({
    super.key,
    required this.order,
    required this.state,
    required this.controller,
    required this.ref,
  });

  final Order order;
  final OrderState state;
  final OrderController controller;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return (order.type == 'consultation' &&
            order.statusCustom == 'Diproses' &&
            DateTime.now().difference(order.items!.createdAt!).inMinutes > 30)
        ? const SizedBox.shrink()
        : order.type == 'custom'
            ? order.statusCustom == 'Menunggu Konfirmasi' ||
                    order.statusCustom == 'Diproses' ||
                    order.statusCustom == 'Selesai' ||
                    order.statusCustom == 'Gagal' ||
                    order.statusCustom == 'Dibatalkan'
                ? const SizedBox.shrink()
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                    width: 1.sw,
                    height: 98.h,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: ColorApp.shadow.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ]),
                    child: order.statusCustom == 'Diterima' &&
                            order.transaction?.statusPayment == 'pending'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: SizedBox(
                              width: 190.w,
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Cara Pembayaran'),
                                        content: SizedBox(
                                          height: 200.h,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              order.transaction?.tokenPayment !=
                                                          null &&
                                                      order
                                                          .transaction!
                                                          .tokenPayment!
                                                          .isNotEmpty
                                                  ? Text(
                                                      'Silahkan lakukan pembayaran ke ${order.transaction!.methodPayment} dengan nominal ${order.transaction!.totalPayment!.currency} dan token ${order.transaction!.tokenPayment}',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )
                                                  : Text(
                                                      'Silahkan lakukan pembayaran ke ${order.transaction!.methodPayment} dengan nominal ${order.transaction!.totalPayment!.currency}',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Tutup'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 4, 192, 202),
                                ),
                                child: Text(
                                  'Bayar Sekarang',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: SizedBox(
                                  width: 140.w,
                                  height: 50.h,
                                  child: ElevatedButton(
                                    onPressed: order.statusCustom == 'Diterima'
                                        ? () {
                                            QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                title:
                                                    'Yakin ingin membatalkan tawaran ini?',
                                                backgroundColor: Colors.white,
                                                showCancelBtn: true,
                                                cancelBtnText: 'Tidak',
                                                confirmBtnText: 'Iya',
                                                confirmBtnColor: ColorApp.red,
                                                onConfirmBtnTap: () {
                                                  controller.cancelOrder(
                                                      order.id ?? '');
                                                  controller.fetchOrders('user',
                                                      order.customer?.id ?? '');
                                                  ref
                                                      .read(goRouterProvider)
                                                      .goNamed(Routes
                                                          .botNavBar.name);
                                                  ref
                                                      .read(
                                                          commonControllerProvider
                                                              .notifier)
                                                      .setPage(0);
                                                });
                                          }
                                        : () {},
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        // color: ColorApp.red,
                                        color: order.statusCustom == 'Dikirim'
                                            ? const Color(0xFFf06906)
                                            : ColorApp.grey,
                                      ),
                                    ),
                                    child: Text(
                                      order.statusCustom == 'Diterima'
                                          ? 'Batalkan'
                                          : order.statusCustom == 'Dikirim'
                                              ? 'Lacak'
                                              : 'Batalkan',
                                      style: TextStyle(
                                        color: order.statusCustom == 'Diterima'
                                            ? ColorApp.red
                                            : order.statusCustom == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : Colors.grey,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: SizedBox(
                                  width: 190.w,
                                  height: 50.h,
                                  child: ElevatedButton(
                                    onPressed: order.statusCustom ==
                                            'Menunggu Konfirmasi'
                                        ? () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16.w,
                                                            vertical: 16.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                30.r),
                                                        topRight:
                                                            Radius.circular(
                                                                30.r),
                                                      ),
                                                    ),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Gap.h20,
                                                          Center(
                                                            child: Container(
                                                              width: 50.w,
                                                              height: 4.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ColorApp
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
                                                            ),
                                                          ),
                                                          Gap.h20,
                                                          Text(
                                                            'Konfirmasi Pesanan',
                                                            style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Gap.h24,
                                                          Text(
                                                            'Berikan harga untuk pesanan pelanggan',
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Gap.h8,
                                                          TextFormField(
                                                            controller: state
                                                                .priceController,
                                                            autofocus: true,
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Harga tidak boleh kosong';
                                                              }
                                                              return null;
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Masukkan harga',
                                                              hintStyle: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.r),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Gap.h24,
                                                          SizedBox(
                                                            width: 1.sw,
                                                            height: 60.h,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                controller.confirmOrder(
                                                                    int.parse(state
                                                                        .priceController
                                                                        .text),
                                                                    order.id!);
                                                                QuickAlert.show(
                                                                    context:
                                                                        context,
                                                                    type: QuickAlertType
                                                                        .success,
                                                                    title:
                                                                        'Berhasil',
                                                                    showCancelBtn:
                                                                        false,
                                                                    barrierDismissible:
                                                                        false,
                                                                    confirmBtnText:
                                                                        'Kembali ke Beranda',
                                                                    onConfirmBtnTap:
                                                                        () {
                                                                      final user = ref
                                                                          .read(
                                                                              commonControllerProvider)
                                                                          .userValue
                                                                          .asData
                                                                          ?.value;
                                                                      controller
                                                                          .fetchOrders(
                                                                        user?.role ??
                                                                            '',
                                                                        user?.id ??
                                                                            '',
                                                                      );
                                                                      ref
                                                                          .read(commonControllerProvider
                                                                              .notifier)
                                                                          .setPage(
                                                                              0);
                                                                      context.goNamed(Routes
                                                                          .botNavBar
                                                                          .name);
                                                                    });
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    ColorApp
                                                                        .primary,
                                                              ),
                                                              child: Text(
                                                                'Terima Pesanan',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        : order.statusCustom == 'Diterima'
                                            ? () {
                                                controller.setValueOrder(
                                                    order.items?.price);

                                                context.pushNamed(
                                                    Routes.orderConfirm.name,
                                                    extra: Extras(datas: {
                                                      ExtrasKey.order: order
                                                    }));
                                              }
                                            : order.statusCustom == 'Dikirim'
                                                ? () {
                                                    QuickAlert.show(
                                                        context: context,
                                                        type: QuickAlertType
                                                            .confirm,
                                                        title:
                                                            'Apakah kamu sudah menerima pesananmu?',
                                                        backgroundColor:
                                                            Colors.white,
                                                        showCancelBtn: true,
                                                        cancelBtnText: 'Tidak',
                                                        confirmBtnText: 'Iya',
                                                        confirmBtnColor:
                                                            const Color(
                                                                0xFFf06906),
                                                        onConfirmBtnTap: () {
                                                          controller
                                                              .confirmDeliveryOrder(
                                                                  order.id ??
                                                                      '');
                                                          controller.fetchOrders(
                                                              'user',
                                                              order.customer
                                                                      ?.id ??
                                                                  '');
                                                          context.pop();
                                                          context.pop();
                                                        });
                                                  }
                                                : () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          order.statusCustom == 'Diterima'
                                              ? const Color.fromARGB(
                                                  255, 4, 192, 202)
                                              : order.statusCustom == 'Dikirim'
                                                  ? const Color(0xFFf06906)
                                                  : ColorApp.primary,
                                    ),
                                    child: Text(
                                      order.statusCustom == 'Diterima'
                                          ? 'Terima Tawaran'
                                          : order.statusCustom == 'Dikirim'
                                              ? 'Sudah Diterima'
                                              : 'Detail',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  )
            : order.statusCustom == 'paid' ||
                    order.statusCustom == 'Selesai' ||
                    order.statusCustom == 'Gagal' ||
                    order.statusCustom == 'Dibatalkan'
                ? const SizedBox.shrink()
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                    width: 1.sw,
                    height: 98.h,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: ColorApp.shadow.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ]),
                    child: order.type == 'consultation'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: SizedBox(
                              width: 190.w,
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed: order.statusCustom == 'Diproses'
                                    ? () async {
                                        final String designerId =
                                            order.designer!.id.toString();
                                        final check = await ref
                                            .read(
                                                chatControllerProvider.notifier)
                                            .checkChat(
                                                usersId: ref
                                                    .read(
                                                        commonControllerProvider
                                                            .notifier)
                                                    .getUid(),
                                                contactId: designerId);
                                        if (check) {
                                          final messagesId = await ref
                                              .read(chatControllerProvider
                                                  .notifier)
                                              .getMessagesId(
                                                  usersId: ref
                                                      .read(
                                                          commonControllerProvider
                                                              .notifier)
                                                      .getUid(),
                                                  contactId: designerId);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatDetailPage(
                                                        usersId: designerId,
                                                        messagesId: messagesId),
                                              ));
                                        } else {
                                          await ref
                                              .read(chatControllerProvider
                                                  .notifier)
                                              .createChat(
                                                usersId: ref
                                                    .read(
                                                        commonControllerProvider
                                                            .notifier)
                                                    .getUid(),
                                                contactId: designerId,
                                              );

                                          final messagesId = await ref
                                              .read(chatControllerProvider
                                                  .notifier)
                                              .getMessagesId(
                                                  usersId: ref
                                                      .read(
                                                          commonControllerProvider
                                                              .notifier)
                                                      .getUid(),
                                                  contactId: designerId);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatDetailPage(
                                                        usersId: designerId,
                                                        messagesId: messagesId),
                                              ));
                                        }
                                      }
                                    : () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: order.statusCustom ==
                                          'Diterima'
                                      ? const Color.fromARGB(255, 4, 192, 202)
                                      : order.statusCustom == 'Dikirim'
                                          ? const Color(0xFFf06906)
                                          : order.statusCustom == 'Diproses'
                                              ? const Color(0xFFAB47BC)
                                              : ColorApp.primary,
                                ),
                                child: Text(
                                  order.statusCustom == 'Menunggu Pembayaran'
                                      ? 'Bayar Sekarang'
                                      : order.statusCustom == 'Diproses'
                                          ? 'Chat Sekarang'
                                          : 'Detail',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: SizedBox(
                                  width: 140.w,
                                  height: 50.h,
                                  child: ElevatedButton(
                                    onPressed: order.statusCustom ==
                                            'Menunggu Pembayaran'
                                        ? () async {
                                            QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                title:
                                                    'Yakin ingin membatalkan pesanan ini?',
                                                backgroundColor: Colors.white,
                                                showCancelBtn: true,
                                                cancelBtnText: 'Tidak',
                                                confirmBtnText: 'Iya',
                                                confirmBtnColor: ColorApp.red,
                                                onConfirmBtnTap: () {
                                                  controller.cancelOrder(
                                                      order.id ?? '');
                                                  controller.fetchOrders('user',
                                                      order.customer?.id ?? '');
                                                  ref
                                                      .read(goRouterProvider)
                                                      .goNamed(Routes
                                                          .botNavBar.name);
                                                  ref
                                                      .read(
                                                          commonControllerProvider
                                                              .notifier)
                                                      .setPage(0);
                                                });
                                          }
                                        : () {},
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        // color: ColorApp.red,
                                        color: order.statusCustom == 'Dikirim'
                                            ? const Color(0xFFf06906)
                                            : ColorApp.grey,
                                      ),
                                    ),
                                    child: Text(
                                      order.statusCustom ==
                                              'Menunggu Pembayaran'
                                          ? 'Batalkan'
                                          : order.statusCustom == 'Dikirim'
                                              ? 'Lacak'
                                              : 'Batalkan',
                                      style: TextStyle(
                                        color: order.statusCustom == 'Diterima'
                                            ? ColorApp.red
                                            : order.statusCustom == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : Colors.grey,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: SizedBox(
                                  width: 190.w,
                                  height: 50.h,
                                  child: ElevatedButton(
                                    onPressed: order.statusCustom ==
                                            'Menunggu Pembayaran'
                                        ? () {
                                            // showDialog to give user how to pay
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Cara Pembayaran'),
                                                  content: SizedBox(
                                                    height: 200.h,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Silahkan lakukan pembayaran ke order.methodPayment dengan nominal order.totalPayment
                                                        order.transaction
                                                                        ?.tokenPayment !=
                                                                    null &&
                                                                order
                                                                    .transaction!
                                                                    .tokenPayment!
                                                                    .isNotEmpty
                                                            ? Text(
                                                                'Silahkan lakukan pembayaran ke ${order.transaction!.methodPayment} dengan nominal ${order.transaction!.totalPayment!.currency} dan token ${order.transaction!.tokenPayment}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              )
                                                            : Text(
                                                                'Silahkan lakukan pembayaran ke ${order.transaction!.methodPayment} dengan nominal ${order.transaction!.totalPayment!.currency}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Tutup'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        : order.statusCustom == 'Dikirim'
                                            ? () {
                                                QuickAlert.show(
                                                    context: context,
                                                    type:
                                                        QuickAlertType.confirm,
                                                    title:
                                                        'Apakah kamu sudah menerima pesananmu?',
                                                    backgroundColor:
                                                        Colors.white,
                                                    showCancelBtn: true,
                                                    cancelBtnText: 'Tidak',
                                                    confirmBtnText: 'Iya',
                                                    confirmBtnColor:
                                                        const Color(0xFFf06906),
                                                    onConfirmBtnTap: () {
                                                      controller
                                                          .confirmDeliveryOrder(
                                                              order.id ?? '');
                                                      controller.fetchOrders(
                                                          'user',
                                                          order.customer?.id ??
                                                              '');
                                                      ref
                                                          .read(
                                                              goRouterProvider)
                                                          .goNamed(Routes
                                                              .botNavBar.name);
                                                      ref
                                                          .read(
                                                              commonControllerProvider
                                                                  .notifier)
                                                          .setPage(0);
                                                    });
                                              }
                                            : () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          order.statusCustom == 'Diterima'
                                              ? const Color.fromARGB(
                                                  255, 4, 192, 202)
                                              : order.statusCustom == 'Dikirim'
                                                  ? const Color(0xFFf06906)
                                                  : ColorApp.primary,
                                    ),
                                    child: Text(
                                      order.statusCustom ==
                                              'Menunggu Pembayaran'
                                          ? 'Bayar Sekarang'
                                          : order.statusCustom == 'Dikirim'
                                              ? 'Sudah Diterima'
                                              : 'Detail',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  );
  }
}
