// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map json) => _$OrderImpl(
      id: json['id'] as String?,
      items: json['items'] == null
          ? null
          : CustomProduct.fromJson(
              Map<String, dynamic>.from(json['items'] as Map)),
      designer: json['designer'] == null
          ? null
          : User.fromJson(Map<String, dynamic>.from(json['designer'] as Map)),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(
              Map<String, dynamic>.from(json['customer'] as Map)),
      transaction: json['transaction'] == null
          ? null
          : Transaction.fromJson(
              Map<String, dynamic>.from(json['transaction'] as Map)),
      statusCustom: json['statusCustom'] as String?,
      type: json['type'] as String?,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['createdAt'], const EpochDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('items', instance.items?.toJson());
  writeNotNull('designer', instance.designer?.toJson());
  writeNotNull('customer', instance.customer?.toJson());
  writeNotNull('transaction', instance.transaction?.toJson());
  writeNotNull('statusCustom', instance.statusCustom);
  writeNotNull('type', instance.type);
  writeNotNull(
      'createdAt',
      _$JsonConverterToJson<int, DateTime>(
          instance.createdAt, const EpochDateTimeConverter().toJson));
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
