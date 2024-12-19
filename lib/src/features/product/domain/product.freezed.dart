// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get arUrl => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get materials => throw _privateConstructorUsedError;
  String? get sizes => throw _privateConstructorUsedError;
  String? get colors => throw _privateConstructorUsedError;
  User? get designer => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  int? get qty => throw _privateConstructorUsedError;
  int? get sold => throw _privateConstructorUsedError;
  bool? get isArAvailable => throw _privateConstructorUsedError;
  bool? get isFavorited => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? description,
      String? imageUrl,
      String? arUrl,
      String? category,
      String? materials,
      String? sizes,
      String? colors,
      User? designer,
      String? location,
      String? city,
      double? rating,
      int? price,
      int? qty,
      int? sold,
      bool? isArAvailable,
      bool? isFavorited});

  $UserCopyWith<$Res>? get designer;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? arUrl = freezed,
    Object? category = freezed,
    Object? materials = freezed,
    Object? sizes = freezed,
    Object? colors = freezed,
    Object? designer = freezed,
    Object? location = freezed,
    Object? city = freezed,
    Object? rating = freezed,
    Object? price = freezed,
    Object? qty = freezed,
    Object? sold = freezed,
    Object? isArAvailable = freezed,
    Object? isFavorited = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      arUrl: freezed == arUrl
          ? _value.arUrl
          : arUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: freezed == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as String?,
      sizes: freezed == sizes
          ? _value.sizes
          : sizes // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as String?,
      designer: freezed == designer
          ? _value.designer
          : designer // ignore: cast_nullable_to_non_nullable
              as User?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      qty: freezed == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int?,
      sold: freezed == sold
          ? _value.sold
          : sold // ignore: cast_nullable_to_non_nullable
              as int?,
      isArAvailable: freezed == isArAvailable
          ? _value.isArAvailable
          : isArAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFavorited: freezed == isFavorited
          ? _value.isFavorited
          : isFavorited // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get designer {
    if (_value.designer == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.designer!, (value) {
      return _then(_value.copyWith(designer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? description,
      String? imageUrl,
      String? arUrl,
      String? category,
      String? materials,
      String? sizes,
      String? colors,
      User? designer,
      String? location,
      String? city,
      double? rating,
      int? price,
      int? qty,
      int? sold,
      bool? isArAvailable,
      bool? isFavorited});

  @override
  $UserCopyWith<$Res>? get designer;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? arUrl = freezed,
    Object? category = freezed,
    Object? materials = freezed,
    Object? sizes = freezed,
    Object? colors = freezed,
    Object? designer = freezed,
    Object? location = freezed,
    Object? city = freezed,
    Object? rating = freezed,
    Object? price = freezed,
    Object? qty = freezed,
    Object? sold = freezed,
    Object? isArAvailable = freezed,
    Object? isFavorited = freezed,
  }) {
    return _then(_$ProductImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      arUrl: freezed == arUrl
          ? _value.arUrl
          : arUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: freezed == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as String?,
      sizes: freezed == sizes
          ? _value.sizes
          : sizes // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as String?,
      designer: freezed == designer
          ? _value.designer
          : designer // ignore: cast_nullable_to_non_nullable
              as User?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      qty: freezed == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int?,
      sold: freezed == sold
          ? _value.sold
          : sold // ignore: cast_nullable_to_non_nullable
              as int?,
      isArAvailable: freezed == isArAvailable
          ? _value.isArAvailable
          : isArAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFavorited: freezed == isFavorited
          ? _value.isFavorited
          : isFavorited // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.arUrl,
      this.category,
      this.materials,
      this.sizes,
      this.colors,
      this.designer,
      this.location,
      this.city,
      this.rating,
      this.price,
      this.qty,
      this.sold,
      this.isArAvailable,
      this.isFavorited});

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final String? arUrl;
  @override
  final String? category;
  @override
  final String? materials;
  @override
  final String? sizes;
  @override
  final String? colors;
  @override
  final User? designer;
  @override
  final String? location;
  @override
  final String? city;
  @override
  final double? rating;
  @override
  final int? price;
  @override
  final int? qty;
  @override
  final int? sold;
  @override
  final bool? isArAvailable;
  @override
  final bool? isFavorited;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, imageUrl: $imageUrl, arUrl: $arUrl, category: $category, materials: $materials, sizes: $sizes, colors: $colors, designer: $designer, location: $location, city: $city, rating: $rating, price: $price, qty: $qty, sold: $sold, isArAvailable: $isArAvailable, isFavorited: $isFavorited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.arUrl, arUrl) || other.arUrl == arUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.materials, materials) ||
                other.materials == materials) &&
            (identical(other.sizes, sizes) || other.sizes == sizes) &&
            (identical(other.colors, colors) || other.colors == colors) &&
            (identical(other.designer, designer) ||
                other.designer == designer) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.sold, sold) || other.sold == sold) &&
            (identical(other.isArAvailable, isArAvailable) ||
                other.isArAvailable == isArAvailable) &&
            (identical(other.isFavorited, isFavorited) ||
                other.isFavorited == isFavorited));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      imageUrl,
      arUrl,
      category,
      materials,
      sizes,
      colors,
      designer,
      location,
      city,
      rating,
      price,
      qty,
      sold,
      isArAvailable,
      isFavorited);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {final String? id,
      final String? name,
      final String? description,
      final String? imageUrl,
      final String? arUrl,
      final String? category,
      final String? materials,
      final String? sizes,
      final String? colors,
      final User? designer,
      final String? location,
      final String? city,
      final double? rating,
      final int? price,
      final int? qty,
      final int? sold,
      final bool? isArAvailable,
      final bool? isFavorited}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  String? get arUrl;
  @override
  String? get category;
  @override
  String? get materials;
  @override
  String? get sizes;
  @override
  String? get colors;
  @override
  User? get designer;
  @override
  String? get location;
  @override
  String? get city;
  @override
  double? get rating;
  @override
  int? get price;
  @override
  int? get qty;
  @override
  int? get sold;
  @override
  bool? get isArAvailable;
  @override
  bool? get isFavorited;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
