// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map json) => _$TransactionImpl(
      methodPayment: json['methodPayment'] as String?,
      orderId: json['orderId'] as String?,
      statusPayment: json['statusPayment'] as String?,
      tokenPayment: json['tokenPayment'] as String?,
      totalPayment: const DoubleConverter().fromJson(json['totalPayment']),
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('methodPayment', instance.methodPayment);
  writeNotNull('orderId', instance.orderId);
  writeNotNull('statusPayment', instance.statusPayment);
  writeNotNull('tokenPayment', instance.tokenPayment);
  writeNotNull(
      'totalPayment',
      _$JsonConverterToJson<dynamic, double>(
          instance.totalPayment, const DoubleConverter().toJson));
  return val;
}

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
