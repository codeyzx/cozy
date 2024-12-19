import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<bool?> registerValue;
  final bool isObscure;
  final bool isObscureConfirm;
  final String? roleValue;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  RegisterState({
    this.registerValue = const AsyncData(null),
    this.isObscure = true,
    this.isObscureConfirm = true,
    this.roleValue,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
  });

  bool get isLoading => registerValue.isLoading;

  RegisterState copyWith({
    AsyncValue<bool>? registerValue,
    bool? isObscure,
    bool? isObscureConfirm,
    String? roleValue,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? passwordConfirmController,
  }) {
    return RegisterState(
      registerValue: registerValue ?? this.registerValue,
      isObscure: isObscure ?? this.isObscure,
      isObscureConfirm: isObscureConfirm ?? this.isObscureConfirm,
      roleValue: roleValue ?? this.roleValue,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      passwordConfirmController:
          passwordConfirmController ?? this.passwordConfirmController,
    );
  }
}
