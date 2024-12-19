import 'package:chyess/src/common_widgets/checkmark_indicator/checkmark_indicator.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/features/order/presentation/widgets/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({
    super.key,
    required this.orders,
    required this.ref,
    this.isFirst,
    this.isLast,
  });

  final List<Order>? orders;
  final WidgetRef ref;
  final bool? isFirst;
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderControllerProvider);
    final controller = ref.read(orderControllerProvider.notifier);
    final user = ref.read(commonControllerProvider).userValue.asData?.value;
    return CheckMarkIndicator(
      onRefresh: () async =>
          await controller.fetchOrders(user?.role ?? '', user?.id ?? ''),
      child: orders?.isNotEmpty == true
          ? ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: orders?.length,
              itemBuilder: (context, index) {
                final order = orders![index];
                if ((order.statusCustom == 'Menunggu Pembayaran' &&
                        user?.role == 'designer') ||
                    (order.type == 'consultation' &&
                        isFirst == true &&
                        order.statusCustom == 'Diproses' &&
                        DateTime.now()
                                .difference(order.items!.createdAt!)
                                .inMinutes >
                            30) ||
                    (order.type == 'consultation' &&
                        isLast == true &&
                        order.statusCustom == 'Diproses' &&
                        DateTime.now()
                                .difference(order.items!.createdAt!)
                                .inMinutes <
                            30)) {
                  return const SizedBox.shrink();
                }
                return OrderCardWidget(
                  order: order,
                  controller: controller,
                  state: state,
                  role: user?.role ?? '',
                  ref: ref,
                );
              },
            )
          : SingleChildScrollView(
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
    );
  }
}
