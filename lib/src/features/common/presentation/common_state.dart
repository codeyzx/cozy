import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/common/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class CommonState {
  final bool isHomeActive;
  final bool isChatActive;
  final bool isReservationActive;
  final bool isProfileActive;
  final bool isLastPage;
  final int currentIndex;
  final int currentIndexIndicator;
  final Widget currentScreen;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<User> userValue;
  final AsyncValue<List<User>> designers;

  CommonState({
    this.isHomeActive = true,
    this.isChatActive = false,
    this.isReservationActive = false,
    this.isProfileActive = false,
    this.isLastPage = false,
    this.currentIndex = 0,
    this.currentIndexIndicator = 0,
    this.currentScreen = const HomePage(),
    this.userValue = const AsyncLoading(),
    this.designers = const AsyncLoading(),
  });

  CommonState copyWith({
    bool? isHomeActive,
    bool? isChatActive,
    bool? isReservationActive,
    bool? isProfileActive,
    bool? isLastPage,
    int? currentIndex,
    int? currentIndexIndicator,
    Widget? currentScreen,
    AsyncValue<User>? userValue,
    AsyncValue<List<User>>? designers,
  }) {
    return CommonState(
      isHomeActive: isHomeActive ?? this.isHomeActive,
      isChatActive: isChatActive ?? this.isChatActive,
      isReservationActive: isReservationActive ?? this.isReservationActive,
      isProfileActive: isProfileActive ?? this.isProfileActive,
      isLastPage: isLastPage ?? this.isLastPage,
      currentIndex: currentIndex ?? this.currentIndex,
      currentIndexIndicator:
          currentIndexIndicator ?? this.currentIndexIndicator,
      currentScreen: currentScreen ?? this.currentScreen,
      userValue: userValue ?? this.userValue,
      designers: designers ?? this.designers,
    );
  }
}
