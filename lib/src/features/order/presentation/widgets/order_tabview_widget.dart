import 'package:chyess/src/common_widgets/checkmark_indicator/checkmark_indicator.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/features/order/presentation/widgets/order_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTabViewWidget extends StatelessWidget {
  const OrderTabViewWidget({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderControllerProvider);
    final controller = ref.read(orderControllerProvider.notifier);
    final user = ref.read(commonControllerProvider).userValue.asData?.value;
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: ColorApp.primary,
            indicatorColor: ColorApp.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 55, 133, 236),
            ),
            tabs: const [
              Tab(text: 'Berlangsung'),
              Tab(text: 'Selesai'),
              Tab(text: 'Dibatalkan'),
            ],
          ),
          SizedBox(
            height: 1.sh - 205.h,
            child: AsyncValueWidget(
              value: state.orders,
              data: (orders) => orders?.isEmpty == true
                  ? CheckMarkIndicator(
                      onRefresh: () async => await controller.fetchOrders(
                          user?.role ?? '', user?.id ?? ''),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              'Tidak ada pesanan',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : TabBarView(
                      children: [
                        OrderListWidget(
                          orders: orders!
                              .where(
                                (order) => (order.statusCustom ==
                                        'Menunggu Konfirmasi' ||
                                    order.statusCustom ==
                                        'Menunggu Pembayaran' ||
                                    order.statusCustom == 'paid' ||
                                    order.statusCustom == 'Diterima' ||
                                    order.statusCustom == 'Diproses' ||
                                    order.statusCustom == 'Dikirim'),
                              )
                              .toList(),
                          ref: ref,
                          isFirst: true,
                        ),
                        OrderListWidget(
                          orders: orders
                              .where((order) =>
                                  order.statusCustom == 'Selesai' ||
                                  (order.statusCustom == 'Diproses' &&
                                      order.type == 'consultation'))
                              .toList(),
                          ref: ref,
                          isLast: true,
                        ),
                        OrderListWidget(
                          orders: orders
                              .where(
                                (order) =>
                                    order.statusCustom == 'Gagal' ||
                                    order.statusCustom == 'Dibatalkan',
                              )
                              .toList(),
                          ref: ref,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
