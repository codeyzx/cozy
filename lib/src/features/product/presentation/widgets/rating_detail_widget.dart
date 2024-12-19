import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/review/domain/rating_summary/rating_summary.dart'
    as domain;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingDetailWidget extends StatelessWidget {
  const RatingDetailWidget({
    super.key,
    required this.rating,
  });

  final domain.RatingSummary rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bahan Pakaian',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating.materialRating! - 1
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 24.sp,
                    ),
                  ),
                ),
                Gap.w4,
                Text(
                  rating.materialRating!.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap.h8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ukuran Pakaian',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating.sizeRating! - 1
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 24.sp,
                    ),
                  ),
                ),
                Gap.w4,
                Text(
                  rating.sizeRating!.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap.h8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kualitas Warna',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating.colorRating! - 1
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 24.sp,
                    ),
                  ),
                ),
                Gap.w4,
                Text(
                  rating.colorRating!.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap.h8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kesesuaian Desain',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating.designerRating! - 1
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 24.sp,
                    ),
                  ),
                ),
                Gap.w4,
                Text(
                  rating.designerRating!.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
