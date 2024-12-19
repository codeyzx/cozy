// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomProductImpl _$$CustomProductImplFromJson(Map json) =>
    _$CustomProductImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      material: json['material'] as String?,
      size: json['size'] as String?,
      color: json['color'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['createdAt'], const EpochDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$CustomProductImplToJson(_$CustomProductImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('material', instance.material);
  writeNotNull('size', instance.size);
  writeNotNull('color', instance.color);
  writeNotNull('qty', instance.qty);
  writeNotNull('price', instance.price);
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
