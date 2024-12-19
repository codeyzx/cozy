import 'package:chyess/src/common_widgets/async_value/async_value_widget.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/product/presentation/product_controller.dart';
import 'package:chyess/src/features/product/presentation/search/widgets/chip_bar_widget.dart';
import 'package:chyess/src/features/product/presentation/search/widgets/product_search_widget.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FilterCategory { semua, promo, termurah, terlaris }

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(productControllerProvider.notifier);
    final state = ref.watch(productControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian', style: TypographyApp.searchText),
        centerTitle: true,
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
              side: BorderSide(color: ColorApp.border, width: 0.3.w),
            ),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 378.w,
                    child: TextField(
                      controller: state.searchController,
                      onChanged: (_) {
                        controller.searchProducts();
                      },
                      style: TypographyApp.txtSearch,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorApp.grey.withOpacity(0.1),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 18.w),
                        hintText: 'Hoodie Halooween',
                        hintStyle: TypographyApp.hintSearch,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: ChipBarWidget(
                      selectedChipIndex: 'semua',
                      enumValues:
                          FilterCategory.values.map((e) => e.name).toList(),
                      onChipSelected: (String chip) {},
                      chips: FilterCategory.values
                          .map((e) => Text(
                              e.name[0].toUpperCase() + e.name.substring(1)))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
              child: AsyncValueWidget(
                value: state.searchProducts,
                data: (products) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap.h12,
                    Text(
                      products?.isEmpty == true
                          ? 'Pakaian tidak ditemukan'
                          : 'Ditemukan ${products?.length} Pakaian',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                    Gap.h12,
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.57,
                      ),
                      itemBuilder: (context, index) {
                        return ProductSearchWidget(product: products![index]);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterWidget extends ConsumerWidget {
  final ScrollController scrollController;
  const FilterWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeApp.w20),
      decoration: BoxDecoration(
        color: ColorApp.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h20,
            Center(
              child: Container(
                width: 50.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorApp.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            Gap.h20,
            Text(
              'Filter',
              style: TypographyApp.headline1,
            ),
            Gap.h24,
            Text(
              'Harga',
              style: TypographyApp.headline3.fontSizeCustom(24.sp),
            ),
            Gap.h8,
            Row(
              children: [
                const FilterChipDateWidget(
                    name: 'Termurah', showCheckmark: false),
                Gap.w16,
                const FilterChipDateWidget(
                    name: 'Termahal', showCheckmark: false),
              ],
            ),
            Gap.h32,
            Text(
              'Rating',
              style: TypographyApp.headline3.fontSizeCustom(24.sp),
            ),
            Gap.h12,
            RatingStars(
              value: 3,
              onValueChanged: (v) {},
              maxValueVisibility: false,
              valueLabelVisibility: false,
              starCount: 5,
              starSize: 50,
              maxValue: 5,
              starSpacing: 8,
              animationDuration: const Duration(milliseconds: 1000),
              starOffColor: const Color(0xffe7e8ea),
              starColor: Colors.amber,
            ),
            Gap.h48,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  height: SizeApp.h56,
                  decoration: BoxDecoration(
                    color: ColorApp.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: ColorApp.black.withOpacity(0.2),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorApp.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      'Reset',
                      style: TypographyApp.text1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: SizeApp.h56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorApp.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Terapkan',
                      style: TypographyApp.text1.white,
                    ),
                  ),
                ),
              ],
            ),
            Gap.h24
          ],
        ),
      ),
    );
  }
}

class CategoryWidget extends ConsumerWidget {
  final int index;
  const CategoryWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(right: SizeApp.w24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: index == 1
                    ? ColorApp.grey.withOpacity(.7)
                    : ColorApp.primary,
                shape: BoxShape.circle,
                boxShadow: index == 1
                    ? []
                    : [
                        BoxShadow(
                            blurRadius: 35,
                            offset: const Offset(0, 10),
                            color: ColorApp.primary.withOpacity(.2))
                      ],
              ),
              child: const Icon(
                Icons.checklist,
                color: ColorApp.white,
                size: 42,
              ),
            ),
          ),
          Gap.h12,
          Text(
            index == 0
                ? 'Linen'
                : index == 1
                    ? 'Polyster'
                    : index == 2
                        ? 'Rayon'
                        : 'Katun',
            style: TypographyApp.headline3.copyWith(
              fontSize: 18.sp,
            ),
          )
        ],
      ),
    );
  }
}

class FilterChipDateWidget extends ConsumerWidget {
  final String name;
  final bool? showCheckmark;
  const FilterChipDateWidget({
    super.key,
    required this.name,
    this.showCheckmark = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilterChip(
      label: Text(
        name.capitalize,
        style: TypographyApp.text1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: const BorderSide(
          color: ColorApp.grey,
        ),
      ),
      backgroundColor: ColorApp.white,
      selectedColor: ColorApp.primary,
      selectedShadowColor: ColorApp.primary.withOpacity(0.2),
      labelStyle: TypographyApp.text2,
      checkmarkColor: ColorApp.white,
      selected: false,
      onSelected: (bool value) {},
      showCheckmark: showCheckmark,
    );
  }
}
