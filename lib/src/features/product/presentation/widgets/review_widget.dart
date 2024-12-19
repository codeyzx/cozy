import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/product/presentation/product_detail_page.dart';
import 'package:chyess/src/features/product/presentation/widgets/rating_detail_widget.dart';
import 'package:chyess/src/features/review/domain/rating_summary/rating_summary.dart'
    as domain;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rating_summary/rating_summary.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
    required this.rating,
  });

  final domain.RatingSummary? rating;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rating == null
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          bottom: 20.h,
                        ),
                        child: RatingSummary(
                          counter: rating?.counter ?? 0,
                          average: rating?.average ?? 0,
                          counterFiveStars: rating?.counterFiveStars ?? 0,
                          counterFourStars: rating?.counterFourStars ?? 0,
                          counterThreeStars: rating?.counterThreeStars ?? 0,
                          counterTwoStars: rating?.counterTwoStars ?? 0,
                          counterOneStars: rating?.counterOneStars ?? 0,
                        ),
                      ),
                      RatingDetailWidget(rating: rating!),
                      Gap.h24,
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ulasan (${rating?.counter ?? 0})',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorApp.primary,
                    ),
                  ),
                ),
              ],
            ),

            /// Users Review
            // ListView.builder
            // Container with padding 10, margin 10, border radius 10, color white, shadow, child Column[Row[Circle Image, Column[Text 'Ahmad Joni', Text '4.5', Text '12 Januari 2021']], Text 'Parkiran Ciwaruga adalah tempat parkir yang nyaman dan aman. Dengan harga yang terjangkau, Parkiran Ciwaruga menyediakan fasilitas parkir yang lengkap dan nyaman. Parkiran Ciwaruga juga dilengkapi dengan sistem keamanan yang canggih dan terpercaya.']
            rating != null
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: rating?.ratings?.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return RatingUserWidget(rating: rating!.ratings![index]);
                    },
                  )
                :
                // Belum ada ulasan
                Container(
                    padding: EdgeInsets.all(10.w),
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Belum ada ulasan',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
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
}
