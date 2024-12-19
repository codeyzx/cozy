// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  String? get methodPayment => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  String? get statusPayment => throw _privateConstructorUsedError;
  String? get tokenPayment => throw _privateConstructorUsedError;
  @DoubleConverter()
  double? get totalPayment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {String? methodPayment,
      String? orderId,
      String? statusPayment,
      String? tokenPayment,
      @DoubleConverter() double? totalPayment});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? methodPayment = freezed,
    Object? orderId = freezed,
    Object? statusPayment = freezed,
    Object? tokenPayment = freezed,
    Object? totalPayment = freezed,
  }) {
    return _then(_value.copyWith(
      methodPayment: freezed == methodPayment
          ? _value.methodPayment
          : methodPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenPayment: freezed == tokenPayment
          ? _value.tokenPayment
          : tokenPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
          _$TransactionImpl value, $Res Function(_$TransactionImpl) then) =
      __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? methodPayment,
      String? orderId,
      String? statusPayment,
      String? tokenPayment,
      @DoubleConverter() double? totalPayment});
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
      _$TransactionImpl _value, $Res Function(_$TransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? methodPayment = freezed,
    Object? orderId = freezed,
    Object? statusPayment = freezed,
    Object? tokenPayment = freezed,
    Object? totalPayment = freezed,
  }) {
    return _then(_$TransactionImpl(
      methodPayment: freezed == methodPayment
          ? _value.methodPayment
          : methodPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenPayment: freezed == tokenPayment
          ? _value.tokenPayment
          : tokenPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionImpl implements _Transaction {
  const _$TransactionImpl(
      {this.methodPayment,
      this.orderId,
      this.statusPayment,
      this.tokenPayment,
      @DoubleConverter() this.totalPayment});

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  final String? methodPayment;
  @override
  final String? orderId;
  @override
  final String? statusPayment;
  @override
  final String? tokenPayment;
  @override
  @DoubleConverter()
  final double? totalPayment;

  @override
  String toString() {
    return 'Transaction(methodPayment: $methodPayment, orderId: $orderId, statusPayment: $statusPayment, tokenPayment: $tokenPayment, totalPayment: $totalPayment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.methodPayment, methodPayment) ||
                other.methodPayment == methodPayment) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.statusPayment, statusPayment) ||
                other.statusPayment == statusPayment) &&
            (identical(other.tokenPayment, tokenPayment) ||
                other.tokenPayment == tokenPayment) &&
            (identical(other.totalPayment, totalPayment) ||
                other.totalPayment == totalPayment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, methodPayment, orderId,
      statusPayment, tokenPayment, totalPayment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(
      this,
    );
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction(
      {final String? methodPayment,
      final String? orderId,
      final String? statusPayment,
      final String? tokenPayment,
      @DoubleConverter() final double? totalPayment}) = _$TransactionImpl;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  String? get methodPayment;
  @override
  String? get orderId;
  @override
  String? get statusPayment;
  @override
  String? get tokenPayment;
  @override
  @DoubleConverter()
  double? get totalPayment;
  @override
  @JsonKey(ignore: true)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
