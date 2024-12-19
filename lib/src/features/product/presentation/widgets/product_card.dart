import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/features/product/presentation/widgets/card_tag_widget.dart';
import 'package:chyess/src/features/review/presentation/review_controller.dart';
import 'package:chyess/src/routes/routes.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () async {
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
                // 'https://picsum.photos/200/600',
                product.imageUrl == null || product.imageUrl == ''
                    ? 'https://picsum.photos/200/600'
                    : product.imageUrl!,
                height: 160.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      // 'Kebaya Kostum Edisi Lebaran',
                      product.name!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    // 'Rp127.000',
                    product.price!.currency,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      Gap.w6,
                      Text(
                        // 'Kalimantan Selatan',
                        product.city!,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Gap.h4,
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(width: 5.w),
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
            ),
          ],
        ),
      ),
    );
  }
}
