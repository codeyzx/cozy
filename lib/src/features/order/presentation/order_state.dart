import 'package:chyess/src/features/order/domain/order/order.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class OrderState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<List<Order>?> orders;
  final AsyncValue<Order?> order;
  final AsyncValue<bool?> loadingValue;
  final TextEditingController priceController;
  final TextEditingController totalController;
  final int qty;

  OrderState({
    this.orders = const AsyncLoading(),
    this.order = const AsyncLoading(),
    this.loadingValue = const AsyncData(null),
    required this.priceController,
    required this.totalController,
    this.qty = 1,
  });

  OrderState copyWith({
    AsyncValue<List<Order>?>? orders,
    AsyncValue<Order?>? order,
    AsyncValue<bool?>? loadingValue,
    TextEditingController? priceController,
    TextEditingController? totalController,
    int? qty,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      order: order ?? this.order,
      loadingValue: loadingValue ?? this.loadingValue,
      priceController: priceController ?? this.priceController,
      totalController: totalController ?? this.totalController,
      qty: qty ?? this.qty,
    );
  }
}
