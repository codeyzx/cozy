import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/common/presentation/profile/presentation/profile_controller.dart';
import 'package:chyess/src/features/product/presentation/product_controller.dart';
import 'package:chyess/src/features/product/presentation/search/widgets/product_search_widget.dart';
import 'package:chyess/src/features/product/presentation/widgets/review_widget.dart';
import 'package:chyess/src/features/review/domain/rating_summary/rating_summary.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignerProfilePage extends ConsumerWidget {
  const DesignerProfilePage({
    super.key,
    required this.user,
    this.designer,
    this.rating,
  });

  final User user;
  final RatingSummary? rating;
  final User? designer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productControllerProvider);
    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
              user.role == 'designer' ? 'Profil Kamu' : 'Detail Desainer',
              style: TypographyApp.searchText),
          centerTitle: true,
          actions: [
            if (user.role == 'designer')
              IconButton(
                onPressed: () {
                  ref
                      .read(profileControllerProvider.notifier)
                      .setTextField(designer);
                  ref.read(goRouterProvider).pushNamed(Routes.profileEdit.name);
                },
                icon: const Icon(Icons.edit, color: Colors.black),
                iconSize: 20,
                padding: const EdgeInsets.all(8.0),
                color: Colors.black,
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    side: BorderSide(
                        color: const Color(0xFFCCD1D6), width: 0.3.w),
                  ),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            Gap.w16,
          ],
          leadingWidth: 78.w,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            iconSize: 20,
            padding: const EdgeInsets.all(8.0),
            color: Colors.black,
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
                side: BorderSide(color: const Color(0xFFCCD1D6), width: 0.3.w),
              ),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(8),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 85.w,
                    height: 85.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      image: designer?.photoUrl != null
                          ? DecorationImage(
                              image: NetworkImage(designer?.photoUrl ?? ''),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: Assets.images.profileDefaultImg
                                  .image(
                                    width: 60.w,
                                    height: 60.h,
                                  )
                                  .image,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Gap.w16,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 0.6.sw,
                        child: Text(designer?.name ?? '',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold)),
                      ),
                      Gap.h4,
                      Text('Desainer Pakaian',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w300)),
                      Gap.h4,
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 16, color: Colors.grey),
                          Gap.w4,
                          SizedBox(
                            width: 0.6.sw,
                            child: Text(
                                designer?.city ?? 'Alamat tidak tersedia',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w300)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap.h24,
            _buildLine(),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    labelColor: ColorApp.primary,
                    indicatorColor: ColorApp.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 55, 133, 236),
                    ),
                    tabs: const [
                      Tab(text: 'Informasi'),
                      Tab(text: 'Produk'),
                      Tab(text: 'Ulasan'),
                    ],
                  ),
                  SizedBox(
                    height: 1.sh - 250.h,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap.h24,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              width: 1.w,
                                            ),
                                          ),
                                          child: const Icon(Icons.sell,
                                              color: ColorApp.primary),
                                        ),
                                        Gap.h8,
                                        Column(
                                          children: [
                                            Text('20K+',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: ColorApp.primary,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('Terjual',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              width: 1.w,
                                            ),
                                          ),
                                          child: const Icon(
                                              Icons.card_travel_outlined,
                                              color: ColorApp.primary),
                                        ),
                                        Gap.h8,
                                        Column(
                                          children: [
                                            Text('7',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: ColorApp.primary,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('Produk',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              width: 1.w,
                                            ),
                                          ),
                                          child: const Icon(Icons.star,
                                              color: ColorApp.primary),
                                        ),
                                        Gap.h8,
                                        Column(
                                          children: [
                                            Text('4.5',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ColorApp.primary,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('Rating',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              width: 1.w,
                                            ),
                                          ),
                                          child: const Icon(Icons.rate_review,
                                              color: ColorApp.primary),
                                        ),
                                        Gap.h8,
                                        Column(
                                          children: [
                                            Text('5',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ColorApp.primary,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('Support AR',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Gap.h24,
                              _buildLine(),
                              Gap.h24,
                              _buildTitle('Tentang'),
                              Text(
                                designer?.description ??
                                    'Deskripsi tidak tersedia',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Gap.h18,
                              _buildLine(),
                              Gap.h24,
                              _buildTitle('Kontak'),
                              Gap.h6,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          color: ColorApp.primary, size: 24),
                                      Gap.w8,
                                      Text(
                                          '0${designer?.phone ?? 'Tidak tersedia'}',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                  Gap.h6,
                                  Row(
                                    children: [
                                      const Icon(Icons.email,
                                          color: ColorApp.primary, size: 24),
                                      Gap.w8,
                                      Text(
                                        designer?.email ??
                                            'Email tidak tersedia',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  Gap.h6,
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          color: ColorApp.primary, size: 24),
                                      Gap.w8,
                                      Text(
                                        designer?.address ??
                                            'Alamat tidak tersedia',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 24.h,
                            left: 16.w,
                            right: 16.w,
                          ),
                          child: AsyncValueWidget(
                            value: state.searchProducts,
                            data: (products) => GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: products
                                  ?.where((product) =>
                                      product.designer?.id == designer?.id)
                                  .toList()
                                  .length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 16.h,
                                childAspectRatio: 0.57,
                              ),
                              itemBuilder: (context, index) {
                                final designerProducts = products
                                    ?.where((product) =>
                                        product.designer?.id == designer?.id)
                                    .toList();
                                return ProductSearchWidget(
                                  product: designerProducts![index],
                                );
                              },
                            ),
                          ),
                        ),
                        ReviewWidget(rating: rating),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(height: 1.h, color: Colors.grey[300]);
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
    );
  }
}
