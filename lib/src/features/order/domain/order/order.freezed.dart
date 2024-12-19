// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String? get id => throw _privateConstructorUsedError;
  CustomProduct? get items => throw _privateConstructorUsedError;
  User? get designer => throw _privateConstructorUsedError;
  Customer? get customer => throw _privateConstructorUsedError;
  Transaction? get transaction => throw _privateConstructorUsedError;
  String? get statusCustom => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @EpochDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {String? id,
      CustomProduct? items,
      User? designer,
      Customer? customer,
      Transaction? transaction,
      String? statusCustom,
      String? type,
      @EpochDateTimeConverter() DateTime? createdAt});

  $CustomProductCopyWith<$Res>? get items;
  $UserCopyWith<$Res>? get designer;
  $CustomerCopyWith<$Res>? get customer;
  $TransactionCopyWith<$Res>? get transaction;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? items = freezed,
    Object? designer = freezed,
    Object? customer = freezed,
    Object? transaction = freezed,
    Object? statusCustom = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as CustomProduct?,
      designer: freezed == designer
          ? _value.designer
          : designer // ignore: cast_nullable_to_non_nullable
              as User?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      transaction: freezed == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      statusCustom: freezed == statusCustom
          ? _value.statusCustom
          : statusCustom // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomProductCopyWith<$Res>? get items {
    if (_value.items == null) {
      return null;
    }

    return $CustomProductCopyWith<$Res>(_value.items!, (value) {
      return _then(_value.copyWith(items: value) as $Val);
    });
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

  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transaction {
    if (_value.transaction == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transaction!, (value) {
      return _then(_value.copyWith(transaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CustomProduct? items,
      User? designer,
      Customer? customer,
      Transaction? transaction,
      String? statusCustom,
      String? type,
      @EpochDateTimeConverter() DateTime? createdAt});

  @override
  $CustomProductCopyWith<$Res>? get items;
  @override
  $UserCopyWith<$Res>? get designer;
  @override
  $CustomerCopyWith<$Res>? get customer;
  @override
  $TransactionCopyWith<$Res>? get transaction;
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? items = freezed,
    Object? designer = freezed,
    Object? customer = freezed,
    Object? transaction = freezed,
    Object? statusCustom = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$OrderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as CustomProduct?,
      designer: freezed == designer
          ? _value.designer
          : designer // ignore: cast_nullable_to_non_nullable
              as User?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      transaction: freezed == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      statusCustom: freezed == statusCustom
          ? _value.statusCustom
          : statusCustom // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
      {this.id,
      this.items,
      this.designer,
      this.customer,
      this.transaction,
      this.statusCustom,
      this.type,
      @EpochDateTimeConverter() this.createdAt});

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String? id;
  @override
  final CustomProduct? items;
  @override
  final User? designer;
  @override
  final Customer? customer;
  @override
  final Transaction? transaction;
  @override
  final String? statusCustom;
  @override
  final String? type;
  @override
  @EpochDateTimeConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Order(id: $id, items: $items, designer: $designer, customer: $customer, transaction: $transaction, statusCustom: $statusCustom, type: $type, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.items, items) || other.items == items) &&
            (identical(other.designer, designer) ||
                other.designer == designer) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.statusCustom, statusCustom) ||
                other.statusCustom == statusCustom) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, items, designer, customer,
      transaction, statusCustom, type, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {final String? id,
      final CustomProduct? items,
      final User? designer,
      final Customer? customer,
      final Transaction? transaction,
      final String? statusCustom,
      final String? type,
      @EpochDateTimeConverter() final DateTime? createdAt}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String? get id;
  @override
  CustomProduct? get items;
  @override
  User? get designer;
  @override
  Customer? get customer;
  @override
  Transaction? get transaction;
  @override
  String? get statusCustom;
  @override
  String? get type;
  @override
  @EpochDateTimeConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
