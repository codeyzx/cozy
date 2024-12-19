import 'package:card_swiper/card_swiper.dart';
import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/checkmark_indicator/checkmark_indicator.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/common/presentation/common_state.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/features/product/presentation/product_controller.dart';
import 'package:chyess/src/features/product/presentation/product_state.dart';
import 'package:chyess/src/features/product/presentation/widgets/product_card.dart';
import 'package:chyess/src/features/review/presentation/review_controller.dart';
import 'package:chyess/src/routes/routes.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(commonControllerProvider.notifier);
    final state = ref.watch(commonControllerProvider);
    final productState = ref.watch(productControllerProvider);
    final user = state.userValue.asData?.value;

    return StatusBarWidget(
      color: const Color(0xFF3785FC),
      child: Scaffold(
        body: CheckMarkIndicator(
          onRefresh: () async {
            await controller.getProfile();
            await ref
                .read(orderControllerProvider.notifier)
                .fetchOrders(user?.role ?? '', user?.id ?? '');
            await ref.read(productControllerProvider.notifier).fetchProducts();
            await ref.read(commonControllerProvider.notifier).fetchDesigners();
          },
          child: SingleChildScrollView(
            child: user?.role == 'user'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeaderHomeWidget(controller: controller, state: state),
                      Gap.h32,
                      SwiperHomeWidget(controller: controller),
                      Gap.h8,
                      DotsIndicatorHomeWidget(state: state),
                      Gap.h32,
                      PopularProductWidget(
                        productState: productState,
                      ),
                      Gap.h32,
                      const DesignerWidget(),
                      Gap.h24,
                      const TipsTrickWidget(),
                      Gap.h50,
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeaderHomeWidget(
                          controller: controller,
                          state: state,
                          isDesigner: true),
                      Gap.h32,
                      SwiperHomeWidget(controller: controller),
                      Gap.h8,
                      DotsIndicatorHomeWidget(state: state),
                      Gap.h32,
                      user?.isSuccessRegister == false
                          ? Container(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                top: 20.h,
                                bottom: 20.h,
                                right: 20.w,
                              ),
                              margin: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                bottom: 32.h,
                              ),
                              decoration: BoxDecoration(
                                  color: ColorApp.primary,
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Daftarkan TokoMu!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                      'Dapatkan keuntungan dengan mendaftarkan produk custom pakaianmu sekarang!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.pushNamed(Routes.question.name);
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.white),
                                        padding:
                                            WidgetStateProperty.all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 6.h),
                                        ),
                                      ),
                                      child: Text(
                                        'Daftar Sekarang',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : user?.isSuccessRegister == true &&
                                  productState.products.asData!.value!
                                      .where((e) => e.designer?.id == user?.id)
                                      .toList()
                                      .isEmpty
                              ? Container(
                                  padding: EdgeInsets.only(
                                    left: 20.w,
                                    top: 20.h,
                                    bottom: 20.h,
                                    right: 20.w,
                                  ),
                                  margin: EdgeInsets.only(
                                    left: 20.w,
                                    right: 20.w,
                                    bottom: 32.h,
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorApp.primary,
                                      borderRadius: BorderRadius.circular(4.r)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Daftarkan ProdukMu!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                          'Kamu belum mendaftarkan produk custom pakaianmu, daftarkan sekarang!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      SizedBox(
                                        height: 40.h,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context.pushNamed(
                                                Routes.productManage.name);
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    Colors.white),
                                            padding: WidgetStateProperty.all<
                                                EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 6.h),
                                            ),
                                          ),
                                          child: Text(
                                            'Daftar Sekarang',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                    left: 20.w,
                                    top: 20.h,
                                    bottom: 20.h,
                                    right: 20.w,
                                  ),
                                  margin: EdgeInsets.only(
                                    left: 20.w,
                                    right: 20.w,
                                    bottom: 32.h,
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorApp.primary,
                                      borderRadius: BorderRadius.circular(4.r)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Selamat Datang, ${user?.name ?? ''}!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                          'Klik disini untuk melihat profil toko kamu!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      SizedBox(
                                        height: 40.h,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final rating = await ref
                                                .read(reviewControllerProvider
                                                    .notifier)
                                                .fetchRatingsByDesignerId(
                                                  user?.id ?? '',
                                                );

                                            ref
                                                .read(goRouterProvider)
                                                .pushNamed(
                                                    Routes.designerProfile.name,
                                                    extra: rating != null
                                                        ? Extras(datas: {
                                                            ExtrasKey.user:
                                                                user,
                                                            ExtrasKey.rating:
                                                                rating,
                                                            ExtrasKey.designer:
                                                                user,
                                                          })
                                                        : Extras(datas: {
                                                            ExtrasKey.user:
                                                                user,
                                                            ExtrasKey.designer:
                                                                user,
                                                          }));
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    Colors.white),
                                            padding: WidgetStateProperty.all<
                                                EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 6.h),
                                            ),
                                          ),
                                          child: Text(
                                            'Lihat Profil Toko',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                      Visibility(
                        visible: user?.isSuccessRegister == true,
                        child: DesignerProductWidget(
                            productState: productState, uid: user?.id ?? ''),
                      ),
                      Gap.h32,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class TipsTrickWidget extends StatelessWidget {
  const TipsTrickWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeApp.w20,
            right: SizeApp.w12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tips Custom Pakaian',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(.7),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap.h4,
        SizedBox(
          height: 140.h,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                  right: index == 5 ? 20.w : 0,
                ),
                child: Card(
                  margin: EdgeInsets.only(bottom: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      // context.pushNamed(Routes.productDetail.name,
                      //     extra: Extras(
                      //         datas: {ExtrasKey.product: data[index]}));
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 15.h,
                            bottom: 10.h,
                            left: 8.w,
                            right: 12.w,
                          ),
                          width: 280.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '@admin',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.60),
                                    ),
                                  ),
                                  Gap.w8,
                                  Container(
                                    width: 1.w,
                                    height: 12.h,
                                    color: Colors.black.withOpacity(0.60),
                                  ),
                                  Gap.w8,
                                  Text(
                                    '5 Min',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.60),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 180.w,
                                    child: Text(
                                      'Tips Memilih Bahan Pakaian yang Bagus untuk Kesehatan Kulit',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4.r),
                                      child: Image.network(
                                        'https://picsum.photos/200/300',
                                        width: 70.w,
                                        height: 70.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class HeaderHomeWidget extends StatelessWidget {
  final CommonController controller;
  final CommonState state;
  final bool isDesigner;

  const HeaderHomeWidget(
      {super.key,
      required this.controller,
      required this.state,
      this.isDesigner = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF3785FC),
      padding: EdgeInsets.only(
        top: SizeApp.h40,
        left: SizeApp.w20,
        right: SizeApp.w20,
        bottom: SizeApp.h20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LocationRow(controller: controller, state: state),
          Gap.h24,
          Text(
            isDesigner
                ? 'Cozy Hadir Untuk \nMembantu BisnisMu!'
                : 'Temukan Pakaian \nKesukaanMu!',
            style: const TextStyle(
              color: Color(0xFFf4f4fe),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap.h16,
          SearchWidget(isDesigner: isDesigner),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final CommonController controller;
  final CommonState state;

  const _LocationRow({required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: state.userValue.asData?.value.photoUrl != null
                  ? Image.network(
                      state.userValue.asData?.value.photoUrl ?? '',
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.cover,
                    )
                  : CircleAvatar(
                      radius: 20.r,
                      backgroundImage: Assets.images.profileDefaultImg
                          .image(
                            width: 40.w,
                            height: 40.h,
                          )
                          .image,
                      backgroundColor: Colors.white,
                    ),
            ),
            Gap.w8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome Back,',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      // 'Ahmad Joni',
                      state.userValue.asData?.value.name ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFFf4f4fe),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(SizeApp.w8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Assets.icons.icNotif.svg(),
        ),
      ],
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.isDesigner = false});

  final bool isDesigner;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: !isDesigner
                ? () {
                    context.pushNamed(Routes.search.name);
                  }
                : () {
                    context.pushNamed(Routes.productManage.name);
                  },
            child: Container(
              width: 250.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Assets.icons.icSearch.svg(
                    width: 20.w,
                    height: 20.h,
                  ),
                  Gap.w8,
                  Text(
                    isDesigner ? 'Tambahkan Produk' : 'Cari Pakaian Kesukaanmu',
                    style: TextStyle(
                      color: const Color(0xFFD6D2D2),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      letterSpacing: .8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap.w8,
        InkWell(
          onTap: !isDesigner
              ? () {
                  context.pushNamed(Routes.search.name);
                }
              : () {
                  context.pushNamed(Routes.productManage.name);
                },
          child: Container(
            height: 45.h,
            padding: EdgeInsets.all(SizeApp.w12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Assets.icons.icFilter.svg(
              width: 22.w,
              height: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}

class SwiperHomeWidget extends StatelessWidget {
  final CommonController controller;

  const SwiperHomeWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Swiper(
        itemCount: 5,
        autoplay: true,
        viewportFraction: 0.85,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: Image.asset(
                  'assets/images/banner${index + 1}.jpg',
                ).image,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        onIndexChanged: controller.setIndexIndicator,
      ),
    );
  }
}

class DotsIndicatorHomeWidget extends StatelessWidget {
  final CommonState state;

  const DotsIndicatorHomeWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 5,
      position: state.currentIndexIndicator,
      decorator: DotsDecorator(
        size: const Size.square(12.0),
        color: Colors.black.withOpacity(.13),
        activeSize: const Size(28.0, 12.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class DesignerProductWidget extends StatelessWidget {
  const DesignerProductWidget(
      {super.key, required this.productState, required this.uid});

  final ProductState productState;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeApp.w20,
            right: SizeApp.w12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daftar Produk Kamu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: productState.products.asData?.value!
                            .where((e) => e.designer?.id == uid)
                            .toList()
                            .isEmpty ==
                        true
                    ? () {}
                    : () {
                        context.pushNamed(Routes.product.name,
                            extra: Extras(datas: {
                              ExtrasKey.title: 'Daftar Produk Kamu',
                              ExtrasKey.products: productState
                                  .products.asData?.value
                                  ?.where((e) => e.designer?.id == uid)
                                  .toList()
                            }));
                      },
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(.7),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap.h4,
        SizedBox(
          height: 360.h,
          child: AsyncValueWidget(
              value: productState.products,
              data: (products) {
                final designerProducts =
                    products?.where((e) => e.designer?.id == uid).toList();
                return designerProducts?.isEmpty == true
                    ? Container(
                        margin: EdgeInsets.only(
                          left: SizeApp.w16,
                          right: SizeApp.w20,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.60),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Gap.h16,
                              Text(
                                'Kamu belum mempunyai produk',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.60),
                                ),
                              ),
                              Gap.h16,
                              SizedBox(
                                height: 40.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context
                                        .pushNamed(Routes.productManage.name);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.black),
                                    padding:
                                        WidgetStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 6.h),
                                    ),
                                  ),
                                  child: Text(
                                    'Tambahkan Produk',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: designerProducts?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 250.w,
                            margin: EdgeInsets.only(
                              left: 20.w,
                              right: index == 4 ? 20.w : 0,
                            ),
                            child:
                                ProductCard(product: designerProducts![index]),
                          );
                        },
                      );
              }),
        ),
      ],
    );
  }
}

class PopularProductWidget extends StatelessWidget {
  const PopularProductWidget({super.key, required this.productState});

  final ProductState productState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeApp.w20,
            right: SizeApp.w12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Custom Terpopuler',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed(Routes.product.name,
                      extra: Extras(
                        datas: {
                          ExtrasKey.title: 'Custom Terpopuler',
                          ExtrasKey.products:
                              productState.products.asData?.value,
                        },
                      ));
                },
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(.7),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap.h4,
        SizedBox(
          height: 360.h,
          child: AsyncValueWidget(
              value: productState.products,
              data: (products) {
                final popularProducts = products?.take(5).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: popularProducts?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 250.w,
                      margin: EdgeInsets.only(
                        left: 20.w,
                        right: index == 4 ? 20.w : 0,
                      ),
                      child: ProductCard(product: popularProducts![index]),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}

class DesignerWidget extends ConsumerWidget {
  const DesignerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commonControllerProvider);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeApp.w20,
            right: SizeApp.w12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rekomendasi Desainer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () async {
                  await ref
                      .read(commonControllerProvider.notifier)
                      .fetchDesigners();

                  ref.read(goRouterProvider).pushNamed(Routes.designer.name,
                      extra: Extras(
                        datas: {ExtrasKey.user: state.designers.asData?.value},
                      ));
                },
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(.7),
                  ),
                ),
              ),
            ],
          ),
        ),
        AsyncValueWidget(
          value: state.designers,
          data: (designers) => designers.isNotEmpty == true
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: designers.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final designer = designers[index];
                    return DesignerCardWidget(
                        designer: designer,
                        ref: ref,
                        user: state.userValue.asData?.value);
                  },
                )
              :

              // Tidak ada designer
              // Container with border outlined
              // and center text
              // with text 'Tidak ada designer'
              Container(
                  margin: EdgeInsets.only(
                    left: SizeApp.w16,
                    right: SizeApp.w20,
                  ),
                  width: 324.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.60),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      'Tidak ada designer',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.60),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class DesignerCardWidget extends StatelessWidget {
  const DesignerCardWidget({
    super.key,
    required this.designer,
    required this.ref,
    required this.user,
  });

  final User? designer;
  final WidgetRef ref;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: SizeApp.w16,
        right: SizeApp.w20,
      ),
      width: 324.w,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: InkWell(
          onTap: () async {
            final rating = await ref
                .read(reviewControllerProvider.notifier)
                .fetchRatingsByDesignerId(
                  designer?.id ?? '',
                );

            ref.read(goRouterProvider).pushNamed(Routes.designerProfile.name,
                extra: rating != null
                    ? Extras(datas: {
                        ExtrasKey.user: user,
                        ExtrasKey.rating: rating,
                        ExtrasKey.designer: designer,
                      })
                    : Extras(datas: {
                        ExtrasKey.user: user,
                        ExtrasKey.designer: designer,
                      }));
          },
          borderRadius: BorderRadius.circular(4.r),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 10.h,
              left: 8.w,
              right: 12.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    designer?.photoUrl == '' || designer?.photoUrl == null
                        ? Assets.images.cozyLogo.image(
                            width: 100.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: Image.network(
                              // 'https://picsum.photos/200/400',
                              designer?.photoUrl ??
                                  'https://picsum.photos/200/400',
                              width: 100.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Joni Ahmad',
                          designer?.name ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Designer Pakaian',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.60),
                          ),
                        ),
                        Gap.h6,
                        Visibility(
                          visible: designer?.isArAvailable ?? false,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.h,
                            ),
                            margin: EdgeInsets.only(bottom: 5.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: Colors.green,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'AR ✅',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        designer?.rating != null
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      // '4.5 | Jakarta Selatan',
                                      '${designer?.rating ?? '0'} | ${designer?.city ?? ''}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    // '4.5 | Jakarta Selatan',
                                    designer?.city ?? '',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.60),
                  size: 15.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
