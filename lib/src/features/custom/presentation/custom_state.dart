import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/custom/domain/custom_product.dart';
import 'package:chyess/src/features/order/domain/customer/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<bool?> loadingValue;

  // Custom
  CustomProduct? customProduct;
  Customer? customer;
  String? imageUrl;
  String? size;
  String? material;
  User? designer;
  final TextEditingController nameController;
  final TextEditingController colorController;
  // User
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController qtyController;

  CustomState({
    this.customProduct,
    this.loadingValue = const AsyncData(null),
    this.customer,
    this.imageUrl,
    this.size,
    this.designer,
    this.material,
    required this.nameController,
    required this.colorController,
    required this.usernameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.qtyController,
  });

  CustomState copyWith({
    AsyncValue<User?>? designerValue,
    AsyncValue<bool?>? loadingValue,
    CustomProduct? customProduct,
    Customer? customer,
    String? imageUrl,
    String? size,
    String? material,
    User? designer,
    TextEditingController? nameController,
    TextEditingController? colorController,
    TextEditingController? usernameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    TextEditingController? addressController,
    TextEditingController? qtyController,
  }) {
    return CustomState(
      customProduct: customProduct ?? this.customProduct,
      loadingValue: loadingValue ?? this.loadingValue,
      customer: customer ?? this.customer,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      designer: designer ?? this.designer,
      material: material ?? this.material,
      nameController: nameController ?? this.nameController,
      colorController: colorController ?? this.colorController,
      usernameController: usernameController ?? this.usernameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      addressController: addressController ?? this.addressController,
      qtyController: qtyController ?? this.qtyController,
    );
  }
}
