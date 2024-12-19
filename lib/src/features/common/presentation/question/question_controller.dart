import 'package:chyess/src/features/auth/data/auth_repository.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/common/presentation/question/question_state.dart';
import 'package:chyess/src/shared/utils/picker.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_controller.g.dart';

@riverpod
class QuestionController extends _$QuestionController {
  @override
  QuestionState build() {
    return QuestionState(
      phoneController: TextEditingController(),
      addressController: TextEditingController(),
      cityController: TextEditingController(),
      descriptionController: TextEditingController(),
    );
  }

  Future<void> submit() async {
    setLoading();

    final id = ref.read(commonControllerProvider.notifier).getUid();

    final imageUrl = state.imageUrl != null
        ? state.imageUrl!.contains('https')
            ? state.imageUrl!
            : await uploadImages(state.imageUrl!, path: 'custom')
        : '';

    final data = {
      'phone': state.phoneController.text,
      'address': state.addressController.text,
      'city': state.cityController.text,
      'description': state.descriptionController.text,
      'photoUrl': imageUrl,
      'isSuccessRegister': true,
    };

    await ref.read(authRepositoryProvider).updateStatusRegister(id, data);

    setSuccess();
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

  void setLastPage(bool value) {
    state = state.copyWith(
      isLastPage: value,
    );
  }

  void setImageUrl(String imageUrl) {
    state = state.copyWith(
      imageUrl: imageUrl,
    );
  }
}
