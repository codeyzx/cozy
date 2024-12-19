import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/custom/presentation/custom_state.dart';
import 'package:chyess/src/services/remote/dio_client.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_controller.g.dart';

@Riverpod(keepAlive: true)
class CustomController extends _$CustomController {
  @override
  CustomState build() {
    return CustomState(
      nameController: TextEditingController(),
      colorController: TextEditingController(),
      usernameController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
      addressController: TextEditingController(),
      qtyController: TextEditingController(),
    );
  }

  Future<String> getToken(Map<String, dynamic> body) async {
    final resp = await ref.read(dioClientProvider).post('charge', data: body);

    String token = resp['token'];
    return token;
  }

  void setMaterial(String? value) {
    if (value.isNotNull()) {
      state = state.copyWith(material: value);
    }
  }

  void setSize(String? value) {
    if (value.isNotNull()) {
      state = state.copyWith(size: value);
    }
  }

  void setDesigner(User? value) {
    if (value.isNotNull()) {
      state = state.copyWith(designer: value);
    }
  }

  void setImageUrl(String? value) {
    if (value.isNotNull()) {
      state = state.copyWith(imageUrl: value);
    }
  }

  void setLoading() {
    state = state.copyWith(
      loadingValue: const AsyncLoading(),
    );
  }

  void setSuccess() {
    state = state.copyWith(
      loadingValue: const AsyncData(true),
    );
  }

  void dispose() {
    state.nameController.dispose();
    state.colorController.dispose();
    state.usernameController.dispose();
    state.emailController.dispose();
    state.phoneController.dispose();
    state.addressController.dispose();
  }

  void setTextFieldUser(String? username, String? email) {
    state = state.copyWith(
      usernameController: TextEditingController(text: username),
      emailController: TextEditingController(text: email),
    );
  }

  void clear() {
    state = CustomState(
      nameController: TextEditingController(),
      colorController: TextEditingController(),
      usernameController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
      addressController: TextEditingController(),
      qtyController: TextEditingController(),
      customProduct: null,
      customer: null,
      designer: null,
      imageUrl: null,
      material: null,
      size: null,
    );
    dispose();
  }
}
