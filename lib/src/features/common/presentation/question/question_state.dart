import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AsyncValue<bool?> loadingValue;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController descriptionController;
  final bool isLastPage;
  final String? imageUrl;

  QuestionState({
    this.loadingValue = const AsyncValue.data(null),
    required this.phoneController,
    required this.addressController,
    required this.cityController,
    required this.descriptionController,
    this.isLastPage = false,
    this.imageUrl,
  });

  QuestionState copyWith({
    AsyncValue<bool?>? loadingValue,
    TextEditingController? phoneController,
    TextEditingController? addressController,
    TextEditingController? cityController,
    TextEditingController? descriptionController,
    bool? isLastPage,
    String? imageUrl,
  }) {
    return QuestionState(
      loadingValue: loadingValue ?? this.loadingValue,
      phoneController: phoneController ?? this.phoneController,
      addressController: addressController ?? this.addressController,
      cityController: cityController ?? this.cityController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      isLastPage: isLastPage ?? this.isLastPage,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
