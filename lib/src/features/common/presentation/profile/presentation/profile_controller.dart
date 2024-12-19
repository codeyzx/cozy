import 'package:chyess/src/features/auth/data/auth_repository.dart';
import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/common/presentation/profile/presentation/profile_state.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/features/product/presentation/product_controller.dart';
import 'package:chyess/src/shared/utils/picker.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  @override
  ProfileState build() {
    return ProfileState(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
      addressController: TextEditingController(),
      cityController: TextEditingController(),
      descriptionController: TextEditingController(),
    );
  }

  FutureOr<void> updateProfile() async {
    state = state.copyWith(
      loadingValue: const AsyncLoading(),
    );

    final imageUrl = state.imageUrl == state.user?.photoUrl
        ? state.imageUrl
        : state.imageUrl?.isNotEmpty == true
            ? await uploadImages(state.imageUrl ?? '')
            : '';

    // Map<String, String> userPost = {
    //   'userId': state.user.asData?.value?.id ?? '',
    //   'userName': state.nameController.text,
    //   'userPhoto': imageUrl,
    // };

    final user = state.user?.role == 'designer'
        ? User(
            id: state.id ?? '',
            name: state.nameController.text,
            photoUrl: imageUrl,
            address: state.addressController.text,
            city: state.cityController.text,
            description: state.descriptionController.text,
            phone: state.phoneController.text,
            email: state.emailController.text,
          )
        : User(
            id: state.id ?? '',
            name: state.nameController.text,
            photoUrl: imageUrl,
            email: state.emailController.text,
          );

    final result = await ref.read(authRepositoryProvider).updateProfile(user);
    if (state.user?.role == 'designer') {
      await ref
          .read(productControllerProvider.notifier)
          .updateAllProductsByDesignerId(
              state.user?.id ?? '', Product(designer: user));
    }
    // await ref.read(communityRepositoryProvider).updateUserPost(userPost);
    // await ref.read(communityRepositoryProvider).updateUserComments(userPost);

    result.when(
      success: (data) {
        state = state.copyWith(
          loadingValue: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          loadingValue: AsyncError(error, stackTrace),
        );
      },
    );
  }

  void setTextField(User? user) {
    state = state.copyWith(
      nameController: state.nameController..text = user?.name ?? '',
      imageUrl: user?.photoUrl ?? '',
      emailController: state.emailController..text = user?.email ?? '',
      addressController: state.addressController..text = user?.address ?? '',
      cityController: state.cityController..text = user?.city ?? '',
      descriptionController: state.descriptionController
        ..text = user?.description ?? '',
      phoneController: state.phoneController..text = user?.phone ?? '',
      id: user?.id,
      user: user,
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
  }

  void setImageUrl(String imageUrl) {
    state = state.copyWith(
      imageUrl: imageUrl,
    );
  }
}
