import 'package:chyess/src/shared/converter/double_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    String? methodPayment,
    String? orderId,
    String? statusPayment,
    String? tokenPayment,
    @DoubleConverter() double? totalPayment,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
