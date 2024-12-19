// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomProduct _$CustomProductFromJson(Map<String, dynamic> json) {
  return _CustomProduct.fromJson(json);
}

/// @nodoc
mixin _$CustomProduct {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get material => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int? get qty => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  @EpochDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomProductCopyWith<CustomProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomProductCopyWith<$Res> {
  factory $CustomProductCopyWith(
          CustomProduct value, $Res Function(CustomProduct) then) =
      _$CustomProductCopyWithImpl<$Res, CustomProduct>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? imageUrl,
      String? material,
      String? size,
      String? color,
      int? qty,
      double? price,
      @EpochDateTimeConverter() DateTime? createdAt});
}

/// @nodoc
class _$CustomProductCopyWithImpl<$Res, $Val extends CustomProduct>
    implements $CustomProductCopyWith<$Res> {
  _$CustomProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? imageUrl = freezed,
    Object? material = freezed,
    Object? size = freezed,
    Object? color = freezed,
    Object? qty = freezed,
    Object? price = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      material: freezed == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      qty: freezed == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomProductImplCopyWith<$Res>
    implements $CustomProductCopyWith<$Res> {
  factory _$$CustomProductImplCopyWith(
          _$CustomProductImpl value, $Res Function(_$CustomProductImpl) then) =
      __$$CustomProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? imageUrl,
      String? material,
      String? size,
      String? color,
      int? qty,
      double? price,
      @EpochDateTimeConverter() DateTime? createdAt});
}

/// @nodoc
class __$$CustomProductImplCopyWithImpl<$Res>
    extends _$CustomProductCopyWithImpl<$Res, _$CustomProductImpl>
    implements _$$CustomProductImplCopyWith<$Res> {
  __$$CustomProductImplCopyWithImpl(
      _$CustomProductImpl _value, $Res Function(_$CustomProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? imageUrl = freezed,
    Object? material = freezed,
    Object? size = freezed,
    Object? color = freezed,
    Object? qty = freezed,
    Object? price = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CustomProductImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      material: freezed == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      qty: freezed == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomProductImpl implements _CustomProduct {
  const _$CustomProductImpl(
      {this.id,
      this.name,
      this.imageUrl,
      this.material,
      this.size,
      this.color,
      this.qty,
      this.price,
      @EpochDateTimeConverter() this.createdAt});

  factory _$CustomProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomProductImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? imageUrl;
  @override
  final String? material;
  @override
  final String? size;
  @override
  final String? color;
  @override
  final int? qty;
  @override
  final double? price;
  @override
  @EpochDateTimeConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CustomProduct(id: $id, name: $name, imageUrl: $imageUrl, material: $material, size: $size, color: $color, qty: $qty, price: $price, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.material, material) ||
                other.material == material) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, imageUrl, material,
      size, color, qty, price, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomProductImplCopyWith<_$CustomProductImpl> get copyWith =>
      __$$CustomProductImplCopyWithImpl<_$CustomProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomProductImplToJson(
      this,
    );
  }
}

abstract class _CustomProduct implements CustomProduct {
  const factory _CustomProduct(
          {final String? id,
          final String? name,
          final String? imageUrl,
          final String? material,
          final String? size,
          final String? color,
          final int? qty,
          final double? price,
          @EpochDateTimeConverter() final DateTime? createdAt}) =
      _$CustomProductImpl;

  factory _CustomProduct.fromJson(Map<String, dynamic> json) =
      _$CustomProductImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get imageUrl;
  @override
  String? get material;
  @override
  String? get size;
  @override
  String? get color;
  @override
  int? get qty;
  @override
  double? get price;
  @override
  @EpochDateTimeConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CustomProductImplCopyWith<_$CustomProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
