// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return _Rating.fromJson(json);
}

/// @nodoc
mixin _$Rating {
  String? get id => throw _privateConstructorUsedError;
  String? get productId => throw _privateConstructorUsedError;
  double? get materialRating => throw _privateConstructorUsedError;
  double? get sizeRating => throw _privateConstructorUsedError;
  double? get colorRating => throw _privateConstructorUsedError;
  double? get designerRating => throw _privateConstructorUsedError;
  String? get designerId => throw _privateConstructorUsedError;
  double? get overallRating => throw _privateConstructorUsedError;
  Comment? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RatingCopyWith<Rating> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingCopyWith<$Res> {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) then) =
      _$RatingCopyWithImpl<$Res, Rating>;
  @useResult
  $Res call(
      {String? id,
      String? productId,
      double? materialRating,
      double? sizeRating,
      double? colorRating,
      double? designerRating,
      String? designerId,
      double? overallRating,
      Comment? comment});

  $CommentCopyWith<$Res>? get comment;
}

/// @nodoc
class _$RatingCopyWithImpl<$Res, $Val extends Rating>
    implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productId = freezed,
    Object? materialRating = freezed,
    Object? sizeRating = freezed,
    Object? colorRating = freezed,
    Object? designerRating = freezed,
    Object? designerId = freezed,
    Object? overallRating = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      materialRating: freezed == materialRating
          ? _value.materialRating
          : materialRating // ignore: cast_nullable_to_non_nullable
              as double?,
      sizeRating: freezed == sizeRating
          ? _value.sizeRating
          : sizeRating // ignore: cast_nullable_to_non_nullable
              as double?,
      colorRating: freezed == colorRating
          ? _value.colorRating
          : colorRating // ignore: cast_nullable_to_non_nullable
              as double?,
      designerRating: freezed == designerRating
          ? _value.designerRating
          : designerRating // ignore: cast_nullable_to_non_nullable
              as double?,
      designerId: freezed == designerId
          ? _value.designerId
          : designerId // ignore: cast_nullable_to_non_nullable
              as String?,
      overallRating: freezed == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as double?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as Comment?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentCopyWith<$Res>? get comment {
    if (_value.comment == null) {
      return null;
    }

    return $CommentCopyWith<$Res>(_value.comment!, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RatingImplCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$$RatingImplCopyWith(
          _$RatingImpl value, $Res Function(_$RatingImpl) then) =
      __$$RatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? productId,
      double? materialRating,
      double? sizeRating,
      double? colorRating,
      double? designerRating,
      String? designerId,
      double? overallRating,
      Comment? comment});

  @override
  $CommentCopyWith<$Res>? get comment;
}

/// @nodoc
class __$$RatingImplCopyWithImpl<$Res>
    extends _$RatingCopyWithImpl<$Res, _$RatingImpl>
    implements _$$RatingImplCopyWith<$Res> {
  __$$RatingImplCopyWithImpl(
      _$RatingImpl _value, $Res Function(_$RatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productId = freezed,
    Object? materialRating = freezed,
    Object? sizeRating = freezed,
    Object? colorRating = freezed,
    Object? designerRating = freezed,
    Object? designerId = freezed,
    Object? overallRating = freezed,
    Object? comment = freezed,
  }) {
    return _then(_$RatingImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      materialRating: freezed == materialRating
          ? _value.materialRating
          : materialRating // ignore: cast_nullable_to_non_nullable
              as double?,
      sizeRating: freezed == sizeRating
          ? _value.sizeRating
          : sizeRating // ignore: cast_nullable_to_non_nullable
              as double?,
      colorRating: freezed == colorRating
          ? _value.colorRating
          : colorRating // ignore: cast_nullable_to_non_nullable
              as double?,
      designerRating: freezed == designerRating
          ? _value.designerRating
          : designerRating // ignore: cast_nullable_to_non_nullable
              as double?,
      designerId: freezed == designerId
          ? _value.designerId
          : designerId // ignore: cast_nullable_to_non_nullable
              as String?,
      overallRating: freezed == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as double?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as Comment?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingImpl implements _Rating {
  const _$RatingImpl(
      {this.id,
      this.productId,
      this.materialRating,
      this.sizeRating,
      this.colorRating,
      this.designerRating,
      this.designerId,
      this.overallRating,
      this.comment});

  factory _$RatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingImplFromJson(json);

  @override
  final String? id;
  @override
  final String? productId;
  @override
  final double? materialRating;
  @override
  final double? sizeRating;
  @override
  final double? colorRating;
  @override
  final double? designerRating;
  @override
  final String? designerId;
  @override
  final double? overallRating;
  @override
  final Comment? comment;

  @override
  String toString() {
    return 'Rating(id: $id, productId: $productId, materialRating: $materialRating, sizeRating: $sizeRating, colorRating: $colorRating, designerRating: $designerRating, designerId: $designerId, overallRating: $overallRating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.materialRating, materialRating) ||
                other.materialRating == materialRating) &&
            (identical(other.sizeRating, sizeRating) ||
                other.sizeRating == sizeRating) &&
            (identical(other.colorRating, colorRating) ||
                other.colorRating == colorRating) &&
            (identical(other.designerRating, designerRating) ||
                other.designerRating == designerRating) &&
            (identical(other.designerId, designerId) ||
                other.designerId == designerId) &&
            (identical(other.overallRating, overallRating) ||
                other.overallRating == overallRating) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      productId,
      materialRating,
      sizeRating,
      colorRating,
      designerRating,
      designerId,
      overallRating,
      comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      __$$RatingImplCopyWithImpl<_$RatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingImplToJson(
      this,
    );
  }
}

abstract class _Rating implements Rating {
  const factory _Rating(
      {final String? id,
      final String? productId,
      final double? materialRating,
      final double? sizeRating,
      final double? colorRating,
      final double? designerRating,
      final String? designerId,
      final double? overallRating,
      final Comment? comment}) = _$RatingImpl;

  factory _Rating.fromJson(Map<String, dynamic> json) = _$RatingImpl.fromJson;

  @override
  String? get id;
  @override
  String? get productId;
  @override
  double? get materialRating;
  @override
  double? get sizeRating;
  @override
  double? get colorRating;
  @override
  double? get designerRating;
  @override
  String? get designerId;
  @override
  double? get overallRating;
  @override
  Comment? get comment;
  @override
  @JsonKey(ignore: true)
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
