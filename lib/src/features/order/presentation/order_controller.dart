import 'package:chyess/src/features/order/data/order_repository.dart';
import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:chyess/src/features/order/presentation/order_state.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_controller.g.dart';

@Riverpod(keepAlive: true)
class OrderController extends _$OrderController {
  @override
  OrderState build() {
    return OrderState(
      priceController: TextEditingController(),
      totalController: TextEditingController(),
    );
  }

  void setValueOrder(double? price) {
    state = state.copyWith(
      priceController: state.priceController..text = price?.currency ?? '',
      totalController: state.totalController..text = price?.currency ?? '',
    );
  }

  void onChangeQty(int? qty) {
    final price = state.priceController.text.replaceAll('Rp', '');
    final newPrice = int.parse(price.replaceAll('.', ''));
    final total = newPrice * qty!;
    state = state.copyWith(
      qty: qty,
      totalController: state.totalController..text = total.currency.toString(),
    );
  }

  Future<void> fetchOrders(String role, String uid) async {
    final result = role == 'user'
        ? await ref.read(orderRepositoryProvider).getOrders(uid: uid)
        : await ref.read(orderRepositoryProvider).getOrders(designerId: uid);
    result.when(
      success: (orders) {
        orders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        state = state.copyWith(orders: AsyncData(orders));
      },
      failure: (e, s) {
        state = state.copyWith(orders: AsyncError(e, s));
      },
    );
  }

  Future<void> fetchOrder(String id) async {
    final result = await ref.read(orderRepositoryProvider).getOrder(id);
    result.when(
      success: (order) {
        state = state.copyWith(order: AsyncData(order));
      },
      failure: (e, s) {
        state = state.copyWith(order: AsyncError(e, s));
      },
    );
  }

  Future<void> addOrder(Order order) async {
    state = state.copyWith(
      orders: const AsyncLoading(),
    );

    final result = await ref.read(orderRepositoryProvider).addOrder(order);

    result.when(
      success: (_) {},
      failure: (e, s) {
        Logger().e(e);
      },
    );
  }

  Future<void> addTransaction(Order order) async {
    state = state.copyWith(
      orders: const AsyncLoading(),
    );

    final result =
        await ref.read(orderRepositoryProvider).addTransaction(order);

    result.when(
      success: (_) {},
      failure: (e, s) {
        Logger().e(e);
      },
    );
  }

  Future<void> confirmOrder(int price, String orderId) async {
    state = state.copyWith(
      orders: const AsyncLoading(),
    );

    final result =
        await ref.read(orderRepositoryProvider).confirmOrder(price, orderId);

    result.when(
      success: (_) {},
      failure: (e, s) {
        Logger().e(e);
      },
    );
  }

  Future<void> confirmDeliveryOrder(String orderId) async {
    state = state.copyWith(
      orders: const AsyncLoading(),
    );

    final result =
        await ref.read(orderRepositoryProvider).confirmDeliveryOrder(orderId);

    result.when(
      success: (_) {},
      failure: (e, s) {
        Logger().e(e);
      },
    );
  }

  // confirmSendOrder
  Future<void> confirmSendOrder(String orderId) async {
    state = state.copyWith(
      orders: const AsyncLoading(),
    );

    final result =
        await ref.read(orderRepositoryProvider).confirmSendOrder(orderId);

    result.when(
      success: (_) {},
      failure: (e, s) {
        Logger().e(e);
      },
    );
  }

  Future<void> cancelOrder(String orderId) async {
    state = state.copyWith(
      orders: const AsyncLoading(),
    );

    final result = await ref.read(orderRepositoryProvider).cancelOrder(orderId);

    result.when(
      success: (_) {},
      failure: (e, s) {
        Logger().e(e);
      },
    );
  }
}
