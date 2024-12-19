import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState {
  final AsyncValue<bool?> loadingValue;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController descriptionController;
  final String? imageUrl;
  final String? id;
  final User? user;

  ProfileState({
    this.loadingValue = const AsyncData(null),
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.cityController,
    required this.descriptionController,
    this.imageUrl,
    this.id,
    this.user,
  });

  ProfileState copyWith({
    AsyncValue<bool>? loadingValue,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    TextEditingController? addressController,
    TextEditingController? cityController,
    TextEditingController? descriptionController,
    String? imageUrl,
    String? id,
    User? user,
  }) {
    return ProfileState(
      loadingValue: loadingValue ?? this.loadingValue,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      addressController: addressController ?? this.addressController,
      cityController: cityController ?? this.cityController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }
}
