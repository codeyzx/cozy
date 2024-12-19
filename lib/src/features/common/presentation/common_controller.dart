import 'package:chyess/src/features/chat/presentation/chat_page.dart';
import 'package:chyess/src/features/common/data/common_repository.dart';
import 'package:chyess/src/features/common/presentation/common_state.dart';
import 'package:chyess/src/features/common/presentation/home/home_page.dart';
import 'package:chyess/src/features/common/presentation/profile/presentation/profile_page.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/features/order/presentation/order_page.dart';
import 'package:chyess/src/features/product/presentation/product_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'common_controller.g.dart';

@Riverpod(keepAlive: true)
class CommonController extends _$CommonController {
  @override
  CommonState build() {
    return CommonState();
  }

  void setLastPage(bool value) {
    state = state.copyWith(
      isLastPage: value,
    );
  }

  void setIndexIndicator(int index) {
    state = state.copyWith(
      currentIndexIndicator: index,
    );
  }

  Future<bool> isOnboarded() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'onboard');
    if (value == null) {
      await storage.write(key: 'onboard', value: 'true');
      return false;
    }
    return true;
  }

  void checkSplash() {
    Future.delayed(const Duration(seconds: 3), () async {
      final isNewUser = await isOnboarded();
      if (isNewUser) {
        final isLogin = ref.read(commonRepositoryProvider).isLogin();
        if (isLogin) {
          await getProfile();
          final user = state.userValue.asData?.value;
          await ref.read(productControllerProvider.notifier).fetchProducts();
          await fetchDesigners();
          await ref.read(orderControllerProvider.notifier).fetchOrders(
                user?.role ?? '',
                user?.id ?? '',
              );
          ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
          // final isSuccessRegister =
          //     state.userValue.asData?.value.isSuccessRegister ?? false;
          // if (isSuccessRegister) {
          //   // final uid = getUid();
          //   // final conceptionDate =
          //   //     state.userValue.asData?.value.fetalDate ?? DateTime.now();
          //   // await ref
          //   //     .read(nutritionControllerProvider.notifier)
          //   //     .getNutrition(uid);
          //   // await ref
          //   //     .read(consumeLogControllerProvider.notifier)
          //   //     .getConsumeLogs(uid);
          //   // await ref
          //   //     .read(consumeLogControllerProvider.notifier)
          //   //     .getTodayConsumeLog(uid, DateTime.now().toYyyyMMDd);
          //   // await ref
          //   //     .read(consumeLogControllerProvider.notifier)
          //   //     .getTodayConsumeFood(uid, DateTime.now().toYyyyMMDd);
          //   // ref.read(consumeLogControllerProvider.notifier).getDate();
          //   // ref
          //   //     .read(medicalRecordControllerProvider.notifier)
          //   //     .getTrimester(conceptionDate);
          //   ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
          // } else {
          //   ref.read(goRouterProvider).goNamed(Routes.question.name);
          // }
        } else {
          ref.read(goRouterProvider).goNamed(Routes.login.name);
        }
      } else {
        ref.read(goRouterProvider).goNamed(Routes.onboard.name);
      }

      //!
      // ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
    });
  }

  void setPage(index) {
    if (index == 2) {
      return;
    }
    state = state.copyWith(
      currentIndex: index,
      currentScreen: _getScreen(index),
      isHomeActive: index == 0,
      isChatActive: index == 1,
      isReservationActive: index == 3,
      isProfileActive: index == 4,
    );
  }

  Widget _getScreen(index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatPage();
      case 3:
        return const OrderPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  String getUid() {
    return ref.read(commonRepositoryProvider).getUid() ?? '';
  }

  Future<void> getProfile() async {
    state = state.copyWith(
      userValue: const AsyncLoading(),
    );

    final result = await ref.read(commonRepositoryProvider).getProfile();
    result.when(
      success: (data) {
        Logger().i(data.toJson());
        state = state.copyWith(
          userValue: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          userValue: AsyncError(error, stackTrace),
        );
      },
    );
  }

  // fetchDesigners
  Future<void> fetchDesigners() async {
    final result = await ref.read(commonRepositoryProvider).getDesigners();
    result.when(
      success: (data) {
        state = state.copyWith(
          designers: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          designers: AsyncError(error, stackTrace),
        );
      },
    );
  }
}
