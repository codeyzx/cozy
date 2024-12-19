import 'package:cached_network_image/cached_network_image.dart';
import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/chat/presentation/chat_controller.dart';
import 'package:chyess/src/features/chat/presentation/chat_detail_page.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/features/order/presentation/order_state.dart';
import 'package:chyess/src/features/product/presentation/product_controller.dart';
import 'package:chyess/src/features/review/presentation/review_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/routes/extras.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderCardWidget extends StatelessWidget {
  final Order order;
  final OrderController controller;
  final OrderState state;
  final String role;
  final WidgetRef ref;

  const OrderCardWidget({
    super.key,
    required this.order,
    required this.controller,
    required this.state,
    required this.role,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.w,
        ),
      ),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: () {
            context.pushNamed(Routes.orderDetail.name,
                extra: Extras(datas: {ExtrasKey.order: order}));
          },
          borderRadius: BorderRadius.circular(4.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: order.type == 'consultation'
                      ? [
                          Assets.images.consult.svg(
                            width: 140.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildStatusBadge(
                                  (order.type == 'consultation' &&
                                          order.statusCustom == 'Diproses' &&
                                          DateTime.now()
                                                  .difference(
                                                      order.items!.createdAt!)
                                                  .inMinutes >
                                              30)
                                      ? 'Selesai'
                                      : order.statusCustom ?? '',
                                  role,
                                  order.type ?? '',
                                  order.transaction?.statusPayment ?? '',
                                ),
                                Gap.h5,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  margin: EdgeInsets.only(right: 30.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 16.sp,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Konsultasi',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Divider
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        width: 1.w,
                                        height: 10.h,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        '30 Menit',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Gap.h5,
                                SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    'Konsultasi dengan ${order.designer?.name}',
                                    style: TextStyle(fontSize: 14.sp),
                                    maxLines: 2,
                                  ),
                                ),
                                Gap.h3,
                                // price
                                order.statusCustom == 'Menunggu Konfirmasi' ||
                                        order.statusCustom == 'Ditolak'
                                    ? Container()
                                    : Text(
                                        order.transaction!.totalPayment!
                                            .currency,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                Gap.h3,

                                // DateTime
                                Gap.h3,
                                Text(
                                  // '23 Jun 2024',
                                  order.createdAt!.dateWithDayMonthYear,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                      : [
                          CachedNetworkImage(
                            imageUrl: order.items!.imageUrl!,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 140.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildStatusBadge(
                                  order.statusCustom ?? '',
                                  role,
                                  order.type ?? '',
                                  order.transaction?.statusPayment ?? '',
                                ),
                                Gap.h5,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  margin: EdgeInsets.only(right: 40.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 16.sp,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        order.type == 'custom'
                                            ? 'Custom'
                                            : 'Pakaian',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Divider
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        width: 1.w,
                                        height: 10.h,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        // '1 Barang',
                                        '${order.items?.qty ?? 1} Barang',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Gap.h5,
                                SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    // title,
                                    order.items!.name!,
                                    style: TextStyle(fontSize: 14.sp),
                                    maxLines: 2,
                                  ),
                                ),
                                Gap.h3,
                                // price
                                order.statusCustom == 'Menunggu Konfirmasi' ||
                                        order.statusCustom == 'Ditolak'
                                    ? Container()
                                    : _buildPriceRow(order),
                                Gap.h3,
                                Row(
                                  children: [
                                    Text(
                                      'Size ${order.items!.size!.split(',')[0]}',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Visibility(
                                      visible: order.items!.color != null &&
                                          order.items!.color!.isNotEmpty,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            width: 1.w,
                                            height: 10.h,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 85.w,
                                            child: Text(
                                              order.items!.color!.split(',')[0],
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                // DateTime
                                Gap.h3,
                                Text(
                                  // '23 Jun 2024',
                                  order.createdAt!.dateWithDayMonthYear,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                ),
                Gap.h11,
                _buildActionButtons(
                    (order.type == 'consultation' &&
                            order.statusCustom == 'Diproses' &&
                            DateTime.now()
                                    .difference(order.items!.createdAt!)
                                    .inMinutes >
                                30)
                        ? 'Selesai'
                        : order.statusCustom ?? '',
                    context,
                    role,
                    order.type ?? '',
                    ref,
                    order.transaction?.statusPayment ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
      String status, String role, String type, String? statusPayment) {
    Color badgeColor;
    Color textColor;
    String? text;

    switch (status) {
      case 'paid':
        badgeColor = const Color.fromARGB(77, 55, 133, 236);
        textColor = const Color.fromARGB(255, 55, 133, 236);
        if (role == 'designer') {
          text = 'Pesanan Baru';
        } else {
          badgeColor = const Color.fromARGB(77, 171, 71, 188);
          textColor = const Color(0xFFAB47BC);
          text = 'Diproses';
        }
        break;
      case 'Menunggu Konfirmasi':
        badgeColor = const Color.fromARGB(77, 55, 133, 236);
        textColor = const Color.fromARGB(255, 55, 133, 236);
        if (role == 'designer') text = 'Pesanan Baru';
        break;
      case 'Diterima':
        badgeColor = const Color.fromARGB(74, 70, 212, 219);
        textColor = const Color.fromARGB(255, 4, 192, 202);
        text = 'Penawaran Designer';
        if (role == 'designer') text = 'Menunggu Konfirmasi Pembeli';
        break;
      case 'Dibatalkan':
        badgeColor = const Color.fromARGB(77, 255, 122, 122);
        textColor = const Color.fromARGB(255, 241, 37, 37);
        break;
      case 'Diproses':
        badgeColor = const Color.fromARGB(77, 171, 71, 188);
        textColor = const Color(0xFFAB47BC);
        if (type == 'consultation') text = 'Konsultasi Sedang Berlangung';
        break;
      case 'Dikirim':
        badgeColor = const Color.fromARGB(77, 240, 105, 6);
        textColor = const Color(0xFFf06906);
        break;
      case 'Selesai':
        badgeColor = const Color.fromARGB(77, 134, 222, 111);
        textColor = const Color(0xFF38AD1B);
        break;
      case 'Gagal':
        badgeColor = const Color.fromARGB(77, 255, 122, 122);
        textColor = const Color.fromARGB(255, 241, 37, 37);
        break;
      default:
        badgeColor = const Color.fromARGB(77, 55, 133, 236);
        textColor = const Color.fromARGB(255, 55, 133, 236);
        break;
    }

    if (type == 'custom' &&
        status == 'Diterima' &&
        statusPayment == 'pending') {
      text = 'Menunggu Pembayaran';
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Text(
        text ?? status,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildPriceRow(Order order) {
    return order.transaction?.totalPayment != null
        ? Row(
            children: [
              Text(
                order.transaction!.totalPayment!.currency,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Divider
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                width: 1.w,
                height: 10.h,
                color: Colors.grey,
              ),
              Text(
                '${order.items?.qty} Barang',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        : Row(
            children: [
              Text(
                order.items!.price!.currency,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Divider
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                width: 1.w,
                height: 10.h,
                color: Colors.grey,
              ),
              Text(
                '${order.items?.qty} Barang',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          );
  }

  Widget _buildActionButtons(
    String status,
    BuildContext context,
    String role,
    String type,
    WidgetRef ref,
    String statusPayment,
  ) {
    if (status == 'Dibatalkan' || status == 'Ditolak') {
      return role == 'user'
          ? _buildSingleButton('Order Lagi', ColorApp.primary, context)
          : _buildSingleButton(
              'Detail', Colors.black.withOpacity(0.8), context);
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: role == 'user'
              ? type == 'custom'
                  ? [
                      _buildButton(
                        status == 'Selesai' ? 'Beri Rating' : 'Chat',
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Konfirmasi'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Konfirmasi'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        status == 'Selesai'
                            ? () {
                                // TODO: NAVIGATE TO RATING PAGE
                              }
                            : () async {
                                final String designerId =
                                    order.designer!.id.toString();
                                final check = await ref
                                    .read(chatControllerProvider.notifier)
                                    .checkChat(
                                        usersId: ref
                                            .read(commonControllerProvider
                                                .notifier)
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
                                            .read(commonControllerProvider
                                                .notifier)
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
                              },
                        true,
                      ),
                      _buildButton(
                        statusPayment == 'pending'
                            ? 'Bayar Sekarang'
                            : status == 'Selesai'
                                ? 'Order Lagi'
                                : status == 'Diterima'
                                    ? 'Terima Tawaran'
                                    : 'Status',
                        Colors.white,
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Konfirmasi'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        statusPayment == 'pending'
                            ? () {
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
                              }
                            : order.statusCustom == 'Diterima'
                                ? () {
                                    controller
                                        .setValueOrder(order.items?.price);

                                    context.pushNamed(Routes.orderConfirm.name,
                                        extra: Extras(
                                            datas: {ExtrasKey.order: order}));
                                  }
                                : () {
                                    context.pushNamed(Routes.orderDetail.name,
                                        extra: Extras(
                                            datas: {ExtrasKey.order: order}));
                                  },
                      ),
                    ]
                  : [
                      _buildButton(
                        status == 'Selesai' ? 'Beri Rating' : 'Chat',
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Pembayaran'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'paid' ||
                                                status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Pembayaran'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'paid' ||
                                                status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        status == 'Selesai'
                            ? () {
                                // TODO: NAVIGATE TO RATING PAGE
                              }
                            : () async {
                                final String designerId =
                                    order.designer!.id.toString();
                                final check = await ref
                                    .read(chatControllerProvider.notifier)
                                    .checkChat(
                                        usersId: ref
                                            .read(commonControllerProvider
                                                .notifier)
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
                                            .read(commonControllerProvider
                                                .notifier)
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
                              },
                        true,
                      ),
                      _buildButton(
                        status == 'Selesai' || status == 'Diterima'
                            ? 'Order Lagi'
                            : status == 'paid'
                                ? 'Status'
                                : status == 'Dikirim'
                                    ? 'Detail'
                                    : status == 'Menunggu Pembayaran'
                                        ? 'Bayar'
                                        : 'Detail',
                        Colors.white,
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Pembayaran'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'paid' ||
                                                status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        status == 'Selesai'
                            ? () async {
                                final rating = await ref
                                    .read(reviewControllerProvider.notifier)
                                    .fetchRatingsByProductId(
                                        order.items?.id ?? '');
                                final product = await ref
                                    .read(productControllerProvider.notifier)
                                    .fetchProduct(order.items?.id ?? '');
                                ref.read(goRouterProvider).pushNamed(
                                    Routes.productDetail.name,
                                    extra: Extras(datas: {
                                      ExtrasKey.product: product,
                                      ExtrasKey.rating: rating
                                    }));
                              }
                            : () {
                                context.pushNamed(Routes.orderDetail.name,
                                    extra: Extras(
                                        datas: {ExtrasKey.order: order}));
                              },
                      ),
                    ]
              : type == 'custom'
                  ? [
                      _buildButton(
                        'Chat',
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Konfirmasi'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Konfirmasi'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        () async {
                          final String designerId =
                              order.customer!.id.toString();
                          final check = await ref
                              .read(chatControllerProvider.notifier)
                              .checkChat(
                                  usersId: ref
                                      .read(commonControllerProvider.notifier)
                                      .getUid(),
                                  contactId: designerId);
                          if (check) {
                            final messagesId = await ref
                                .read(chatControllerProvider.notifier)
                                .getMessagesId(
                                    usersId: ref
                                        .read(commonControllerProvider.notifier)
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
                                      .read(commonControllerProvider.notifier)
                                      .getUid(),
                                  contactId: designerId,
                                );

                            final messagesId = await ref
                                .read(chatControllerProvider.notifier)
                                .getMessagesId(
                                    usersId: ref
                                        .read(commonControllerProvider.notifier)
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
                        },
                        true,
                      ),
                      _buildButton(
                        status == 'Diproses' ? 'Kirim Pesanan' : 'Detail',
                        Colors.white,
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Menunggu Konfirmasi'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        () {
                          context.pushNamed(Routes.orderDetail.name,
                              extra: Extras(datas: {ExtrasKey.order: order}));
                        },
                      ),
                    ]
                  : [
                      _buildButton(
                        'Chat',
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Diterima'
                                    ? const Color.fromARGB(255, 4, 192, 202)
                                    : status == 'paid'
                                        ? ColorApp.primary
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'Diterima'
                                    ? const Color.fromARGB(255, 4, 192, 202)
                                    : status == 'paid'
                                        ? ColorApp.primary
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        () async {
                          final String designerId =
                              order.customer!.id.toString();
                          final check = await ref
                              .read(chatControllerProvider.notifier)
                              .checkChat(
                                  usersId: ref
                                      .read(commonControllerProvider.notifier)
                                      .getUid(),
                                  contactId: designerId);
                          if (check) {
                            final messagesId = await ref
                                .read(chatControllerProvider.notifier)
                                .getMessagesId(
                                    usersId: ref
                                        .read(commonControllerProvider.notifier)
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
                                      .read(commonControllerProvider.notifier)
                                      .getUid(),
                                  contactId: designerId,
                                );

                            final messagesId = await ref
                                .read(chatControllerProvider.notifier)
                                .getMessagesId(
                                    usersId: ref
                                        .read(commonControllerProvider.notifier)
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
                        },
                        true,
                      ),
                      _buildButton(
                        status == 'paid' ? 'Kirim Pesanan' : 'Detail',
                        Colors.white,
                        status == 'Selesai'
                            ? const Color(0xFF38AD1B)
                            : status == 'Ditolak'
                                ? const Color(0xFFf06906)
                                : status == 'paid'
                                    ? ColorApp.primary
                                    : status == 'Diterima'
                                        ? const Color.fromARGB(255, 4, 192, 202)
                                        : status == 'Diproses'
                                            ? const Color(0xFFAB47BC)
                                            : status == 'Dikirim'
                                                ? const Color(0xFFf06906)
                                                : status == 'Gagal'
                                                    ? const Color(0xFFf06906)
                                                    : Colors.grey,
                        () {
                          context.pushNamed(Routes.orderDetail.name,
                              extra: Extras(datas: {ExtrasKey.order: order}));
                        },
                      ),
                    ]);
    }
  }

  Widget _buildSingleButton(
    String text,
    Color color,
    BuildContext context,
  ) {
    return Container(
      width: 1.sw - 52.w,
      height: 32.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color, width: 1.w),
      ),
      child: TextButton(
        onPressed: text == 'Detail'
            ? () {
                context.pushNamed(Routes.orderDetail.name,
                    extra: Extras(datas: {ExtrasKey.order: order}));
              }
            : () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      String text, Color textColor, Color borderColor, Function() onPressed,
      [bool isFirst = false]) {
    return Container(
      width: 160.w,
      height: 32.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: borderColor, width: 1.w),
        color: !isFirst ? borderColor : Colors.white,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
