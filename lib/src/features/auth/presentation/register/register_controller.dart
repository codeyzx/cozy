import 'package:chyess/src/features/auth/data/auth_repository.dart';
import 'package:chyess/src/features/auth/domain/request_register.dart';
import 'package:chyess/src/features/auth/presentation/register/register_state.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  RegisterState build() {
    return RegisterState(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      passwordConfirmController: TextEditingController(),
    );
  }

  Future<void> register() async {
    if (!state.formKey.currentState!.validate()) {
      return;
    }

    state = state.copyWith(
      registerValue: const AsyncLoading(),
    );

    final requestRegister = RequestRegister(
      name: state.nameController.text,
      email: state.emailController.text,
      password: state.passwordController.text,
      role: state.roleValue ?? "user",
    );

    final result =
        await ref.read(authRepositoryProvider).register(requestRegister);

    result.when(
      success: (data) {
        state = state.copyWith(
          registerValue: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(registerValue: AsyncError(error, stackTrace));
      },
    );
  }

  void onObscureTap() {
    state = state.copyWith(
      isObscure: !state.isObscure,
    );
  }

  void onObscureConfirmTap() {
    state = state.copyWith(
      isObscureConfirm: !state.isObscureConfirm,
    );
  }

  void onRoleValueChanged(String? value) {
    state = state.copyWith(
      roleValue: value,
    );
  }

  String? validatePassword(String? value) {
    if (value.isNullOrEmpty()) {
      return "Tidak boleh kosong";
    } else if (!value!.isPasswordValid) {
      return "Password harus lebih dari 8 karakter";
    }
    return null;
  }

  String? validatePasswordConfirm(String? value) {
    if (value.isNullOrEmpty()) {
      return "Tidak boleh kosong";
    } else if (!value!.isPasswordValid) {
      return "Password harus lebih dari 8 karakter";
    } else if (value != state.passwordController.text) {
      return "Password tidak sama dengan konfirmasi password";
    }
    return null;
  }
}
