// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map json) => _$ProductImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      arUrl: json['arUrl'] as String?,
      category: json['category'] as String?,
      materials: json['materials'] as String?,
      sizes: json['sizes'] as String?,
      colors: json['colors'] as String?,
      designer: json['designer'] == null
          ? null
          : User.fromJson(Map<String, dynamic>.from(json['designer'] as Map)),
      location: json['location'] as String?,
      city: json['city'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      sold: (json['sold'] as num?)?.toInt(),
      isArAvailable: json['isArAvailable'] as bool?,
      isFavorited: json['isFavorited'] as bool?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('arUrl', instance.arUrl);
  writeNotNull('category', instance.category);
  writeNotNull('materials', instance.materials);
  writeNotNull('sizes', instance.sizes);
  writeNotNull('colors', instance.colors);
  writeNotNull('designer', instance.designer?.toJson());
  writeNotNull('location', instance.location);
  writeNotNull('city', instance.city);
  writeNotNull('rating', instance.rating);
  writeNotNull('price', instance.price);
  writeNotNull('qty', instance.qty);
  writeNotNull('sold', instance.sold);
  writeNotNull('isArAvailable', instance.isArAvailable);
  writeNotNull('isFavorited', instance.isFavorited);
  return val;
}
