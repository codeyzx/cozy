import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/custom/domain/custom_product.dart';
import 'package:chyess/src/features/order/domain/customer/customer.dart';
import 'package:chyess/src/features/order/domain/transaction/transaction.dart';
import 'package:chyess/src/shared/converter/epoch_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    String? id,
    CustomProduct? items,
    User? designer,
    Customer? customer,
    Transaction? transaction,
    String? statusCustom,
    String? type,
    @EpochDateTimeConverter() DateTime? createdAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
