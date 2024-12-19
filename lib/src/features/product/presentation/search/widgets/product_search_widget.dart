import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/features/product/presentation/widgets/card_tag_widget.dart';
import 'package:chyess/src/features/review/presentation/review_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/routes/extras.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSearchWidget extends ConsumerWidget {
  const ProductSearchWidget(
      {super.key, required this.product, this.isDesigner});

  final Product product;
  final bool? isDesigner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: InkWell(
        onTap: isDesigner == true
            ? () {}
            : () async {
                final rating = await ref
                    .read(reviewControllerProvider.notifier)
                    .fetchRatingsByProductId(product.id!);
                ref.read(goRouterProvider).pushNamed(Routes.productDetail.name,
                    extra: Extras(datas: {
                      ExtrasKey.product: product,
                      ExtrasKey.rating: rating
                    }));
              },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              child: Image.network(
                product.imageUrl == null || product.imageUrl == ''
                    ? 'https://picsum.photos/200/600'
                    : product.imageUrl!,
                height: 120.h,
                width: 1.sw,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: product.isArAvailable! ||
                            product.qty! > 0 && product.qty! < 5
                        ? 10.h
                        : 4.h,
                  ),
                  child: Row(
                    children: [
                      product.isArAvailable!
                          ? const CardTagWidget(
                              text: 'AR Available',
                              color: Colors.green,
                            )
                          : const SizedBox.shrink(),
                      product.qty! > 0 && product.qty! < 5
                          ? const CardTagWidget(
                              text: 'Sisa 3 Lagi', color: Colors.red)
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          product.name!,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Gap.h5,
                      Text(
                        product.price!.currency,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap.h5,
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Gap.w5,
                          SizedBox(
                            width: 140.w,
                            child: Text(
                              product.city!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap.h8,
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          Gap.w5,
                          Text(
                            '${product.rating ?? 0} | ${product.sold ?? 0} terjual',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
