import 'package:chyess/src/common_widgets/checkmark_indicator/checkmark_indicator.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/features/product/presentation/search/widgets/product_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key, required this.products, required this.title});

  final List<Product> products;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TypographyApp.searchText),
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
      body: CheckMarkIndicator(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap.h12,
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.57,
                      ),
                      itemBuilder: (context, index) {
                        return ProductSearchWidget(product: products[index]);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
