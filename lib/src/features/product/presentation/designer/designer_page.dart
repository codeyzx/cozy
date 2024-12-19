import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/checkmark_indicator/checkmark_indicator.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/review/presentation/review_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/routes/extras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignerPage extends ConsumerWidget {
  const DesignerPage({super.key, required this.designers});

  final List<User> designers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rekomendasi Desainer', style: TypographyApp.searchText),
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
                      itemCount: designers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return DesignerItemWidget(designer: designers[index]);
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

class DesignerItemWidget extends ConsumerWidget {
  const DesignerItemWidget({super.key, required this.designer});

  final User designer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: InkWell(
        onTap: () async {
          final rating = await ref
              .read(reviewControllerProvider.notifier)
              .fetchRatingsByDesignerId(
                designer.id ?? '',
              );

          final user =
              ref.read(commonControllerProvider).userValue.asData?.value;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              child: designer.photoUrl == null
                  ? Assets.images.cozyLogo.image(
                      height: 120.h,
                      width: 1.sw,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      designer.photoUrl ?? '',
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
                    horizontal: 4.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap.h10,
                      Visibility(
                        visible: designer.isArAvailable ?? false,
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
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          designer.name.toString(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Gap.h5,
                      Text(
                        'Designer Pakaian',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.60),
                        ),
                      ),
                      Gap.h5,
                      designer.rating != null
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
                                    '${designer.rating ?? '0'} | ${designer.city ?? ''}',
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
                                  designer.city ?? '',
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
