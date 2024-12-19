import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<bool?> loginValue;
  final bool isObscure;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginState({
    this.loginValue = const AsyncData(null),
    this.isObscure = true,
    required this.emailController,
    required this.passwordController,
  });

  bool get isLoading => loginValue.isLoading;

  LoginState copyWith({
    AsyncValue<bool>? loginValue,
    bool? isObscure,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return LoginState(
      loginValue: loginValue ?? this.loginValue,
      isObscure: isObscure ?? this.isObscure,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }
}
