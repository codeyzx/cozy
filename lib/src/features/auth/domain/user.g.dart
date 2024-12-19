// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map json) => _$UserImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      role: json['role'] as String?,
      status: json['status'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      isArAvailable: json['isArAvailable'] as bool?,
      isSuccessRegister: json['isSuccessRegister'] as bool?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('photoUrl', instance.photoUrl);
  writeNotNull('role', instance.role);
  writeNotNull('status', instance.status);
  writeNotNull('phone', instance.phone);
  writeNotNull('address', instance.address);
  writeNotNull('city', instance.city);
  writeNotNull('description', instance.description);
  writeNotNull('rating', instance.rating);
  writeNotNull('isArAvailable', instance.isArAvailable);
  writeNotNull('isSuccessRegister', instance.isSuccessRegister);
  return val;
}
