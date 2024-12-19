import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/review/presentation/review_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/routes/extras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotNavBarWidget extends ConsumerWidget {
  const BotNavBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commonControllerProvider);
    final controller = ref.read(commonControllerProvider.notifier);
    final currentIndex = state.currentIndex;
    final currentScreen = state.currentScreen;
    final user = state.userValue.asData?.value;
    final bucket = PageStorageBucket();

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: ColorApp.primary,
              onPressed: user?.role == 'designer'
                  ? () async {
                      final rating = await ref
                          .read(reviewControllerProvider.notifier)
                          .fetchRatingsByDesignerId(
                            user?.id ?? '',
                          );

                      ref
                          .read(goRouterProvider)
                          .pushNamed(Routes.designerProfile.name,
                              extra: rating != null
                                  ? Extras(datas: {
                                      ExtrasKey.user: user,
                                      ExtrasKey.rating: rating,
                                      ExtrasKey.designer: user,
                                    })
                                  : Extras(datas: {
                                      ExtrasKey.user: user,
                                      ExtrasKey.designer: user,
                                    }));
                    }
                  : () async {
                      await controller.fetchDesigners();
                      ref
                          .read(goRouterProvider)
                          .pushNamed(Routes.customDetail.name);
                    },
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 38.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70.0.h,
          child: BottomNavigationBar(
            selectedFontSize: 11.0.sp,
            unselectedFontSize: 11.0.sp,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) => controller.setPage(index),
            items: [
              BottomNavigationBarItem(
                icon: state.isHomeActive
                    ? Assets.icons.icHome.svg(
                        colorFilter: const ColorFilter.mode(
                          ColorApp.black,
                          BlendMode.srcIn,
                        ),
                        height: 24.0.sp,
                      )
                    : Assets.icons.icHome.svg(
                        colorFilter: const ColorFilter.mode(
                          ColorApp.grey,
                          BlendMode.srcIn,
                        ),
                        height: 24.0.sp,
                      ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: state.isChatActive
                    ? Assets.icons.icChat.svg(
                        colorFilter: const ColorFilter.mode(
                          ColorApp.black,
                          BlendMode.srcIn,
                        ),
                        height: 24.0.sp,
                      )
                    : Assets.icons.icChat.svg(
                        colorFilter: const ColorFilter.mode(
                          ColorApp.grey,
                          BlendMode.srcIn,
                        ),
                        height: 24.0.sp,
                      ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(icon: SizedBox(width: 40.w), label: ''),
              BottomNavigationBarItem(
                icon: state.isReservationActive
                    ? Assets.icons.icReservation.svg(
                        colorFilter: const ColorFilter.mode(
                          ColorApp.black,
                          BlendMode.srcIn,
                        ),
                        height: 24.0.sp,
                      )
                    : Assets.icons.icReservation.svg(
                        colorFilter: const ColorFilter.mode(
                          ColorApp.grey,
                          BlendMode.srcIn,
                        ),
                        height: 24.0.sp,
                      ),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: state.isProfileActive
                    ? Assets.icons.icProfile.svg(
                        colorFilter: const ColorFilter.mode(
                          ColorApp.black,
                          BlendMode.srcIn,
                        ),
                        height: 24.0.sp,
                      )
                    : Assets.icons.icProfile.svg(
                        colorFilter: const ColorFilter.mode(
                          ColorApp.grey,
                          BlendMode.srcIn,
                        ),
                        height: 24.0.sp,
                      ),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
