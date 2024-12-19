import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/chat/presentation/chat_controller.dart';
import 'package:chyess/src/features/chat/presentation/chat_detail_page.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/custom/presentation/custom_controller.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/features/product/presentation/widgets/review_widget.dart';
import 'package:chyess/src/features/review/domain/rating/rating.dart';
import 'package:chyess/src/features/review/domain/rating_summary/rating_summary.dart'
    as domain;
import 'package:chyess/src/features/review/presentation/review_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/routes/extras.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage(
      {super.key, required this.product, required this.rating});

  final Product product;
  final domain.RatingSummary? rating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(commonControllerProvider).userValue.asData?.value;
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: AppBar(
            primary: true,
            backgroundColor: Colors.transparent,
            leadingWidth: 78.w,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:
                  const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              iconSize: 20,
              padding: const EdgeInsets.all(8.0),
              color: Colors.black,
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  side:
                      BorderSide(color: const Color(0xFFCCD1D6), width: 0.3.w),
                ),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 20.w),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
                  iconSize: 24,
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
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              product.imageUrl == '' || product.imageUrl == null
                  ? Assets.images.cozyLogo.image(
                      width: 1.sw,
                      height: 290.h,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      product.imageUrl == null || product.imageUrl == ''
                          ? 'https://picsum.photos/200/600'
                          : product.imageUrl!,
                      width: 1.sw,
                      height: 290.h,
                      fit: BoxFit.cover,
                    ),

              /// Title
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 0.56.sw,
                              child: Text(
                                product.name!,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                  size: 16.sp,
                                ),
                                Gap.w4,
                                Text(
                                  product.city!,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Gap.h2,
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20.sp,
                                ),
                                Gap.w4,
                                Text(
                                  product.rating == null
                                      ? '0'
                                      : product.rating.toString(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Container(
                                  width: 1.w,
                                  height: 15.h,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  product.sold == null
                                      ? '0'
                                      : product.sold.toString(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  " terjual",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: ColorApp.primary,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: ColorApp.primary,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 55, 133, 236),
                      ),
                      tabs: const [
                        Tab(
                          text: 'Tentang',
                        ),
                        Tab(
                          text: 'Galeri',
                        ),
                        Tab(
                          text: 'Ulasan',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.sh - 290.h - 70.h - 72.h,
                      child: TabBarView(
                        children: [
                          // Tentang
                          AboutWidget(
                            product: product,
                            ref: ref,
                            rating: rating,
                            user: user,
                          ),
                          // Galeri
                          GalleryWidget(
                            product: product,
                          ),
                          // Ulasan

                          ReviewWidget(
                            // product: product,
                            rating: rating,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          width: 1.sw,
          height: 72.h,
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, -1),
              blurRadius: 4,
            ),
          ]),
          child: user?.role == 'designer'
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: SizedBox(
                    width: 154.w,
                    height: 42.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: ColorApp.primary,
                        ),
                      ),
                      child: Text(
                        'Edit Produk',
                        style: TextStyle(
                          color: ColorApp.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: SizedBox(
                        width: 154.w,
                        height: 42.h,
                        child: ElevatedButton(
                          onPressed:
                              product.arUrl == null || product.arUrl == ''
                                  ? () {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title:
                                            'Produk ini tidak memiliki tampilan 3D',
                                        showCancelBtn: false,
                                        confirmBtnText: 'Kembali',
                                      );
                                    }
                                  : () {
                                      context.pushNamed(Routes.ar.name,
                                          extra: Extras(datas: {
                                            ExtrasKey.arUrl: product.arUrl ??
                                                'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
                                            ExtrasKey.title: product.name,
                                          }));
                                    },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                              color: ColorApp.primary,
                            ),
                          ),
                          child: Text(
                            'AR View',
                            style: TextStyle(
                              color: ColorApp.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: SizedBox(
                        width: 154.w,
                        height: 42.h,
                        child: ElevatedButton(
                          onPressed: () {
                            ref
                                .read(customControllerProvider.notifier)
                                .setTextFieldUser(user?.name, user?.email);

                            context.pushNamed(Routes.customDetailPersonal.name,
                                extra: Extras(
                                    datas: {ExtrasKey.product: product}));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.primary,
                          ),
                          child: Text(
                            'Pesan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}

class RatingUserWidget extends StatelessWidget {
  const RatingUserWidget({super.key, required this.rating});

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/200/300',
                      // comment.user!.photoUrl!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap.w8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 'Ahmad Joni',
                    // comment.user!.name!,
                    rating.comment!.userId!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Row[5 Icon Star, Text '12 Januari 2021']
                  Row(
                    children: [
                      // Row(
                      //   children: List.generate(
                      //     5,
                      //     (index) => Icon(
                      //       index < 4
                      //           ? Icons.star
                      //           : Icons.star_border,
                      //       color: Colors.amber,
                      //       size: 16.sp,
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < rating.overallRating!.toInt()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16.sp,
                          ),
                        ),
                      ),

                      Gap.w4,
                      Text(
                        rating.comment!.createdAt!.pastDate,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Gap.h8,
          Text(
            // 'Batik nya bagus, nyaman dipakai, dan harga nya terjangkau. Ga nyesel beli disini. Terima kasih banyak!',
            rating.comment!.text!,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(
        bottom: 80.h,
      ),
      color: Colors.transparent,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 1,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            margin: index == 0 || index == 1
                ? EdgeInsets.only(top: 30.h)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(
                  // 'https://picsum.photos/200/300',
                  product.imageUrl == null || product.imageUrl == ''
                      ? 'https://picsum.photos/200/600'
                      : product.imageUrl!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AboutWidget extends StatelessWidget {
  const AboutWidget({
    super.key,
    required this.product,
    required this.ref,
    required this.rating,
    required this.user,
  });

  final Product product;
  final WidgetRef ref;
  final domain.RatingSummary? rating;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 120.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Deskripsi
            Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap.h8,
            Text(
              // 'Batik ini merupakan batik yang dibuat dengan tangan oleh para pengrajin batik di Indonesia. Batik ini memiliki motif yang unik dan menarik, sehingga cocok digunakan untuk acara formal maupun non-formal. Batik ini juga memiliki kualitas yang baik dan nyaman digunakan.',
              product.description!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap.h24,

            /// Informasi Parkir
            Text(
              'Detail',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap.h8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//                 Ukuran S, M, L, XL
// Bahan Cotton dan Polynum
// Warna Hitam, Putih, Biru, Merah
// Harga Rp 150.000
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ukuran Pakaian',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Gap.w8,
                    Text(
                      // 'S, M, L, XL',
                      product.sizes!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Gap.h8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bahan Pakaian',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Gap.w8,
                    Text(
                      // 'Cotton dan Polynum',
                      product.materials!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Gap.h8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Warna Pakaian',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap.w8,
                    Text(
                      // 'Hitam, Putih, Biru, Merah',
                      product.colors!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Gap.h8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Alamat Lengkap',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap.w8,
                    SizedBox(
                      width: 0.4.sw,
                      child: Text(
                        // 'Rp 150.000',
                        product.location!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color.fromARGB(255, 94, 156, 250),
                          fontWeight: FontWeight.w500,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap.h24,

            /// Dioperasikan Oleh
            Text(
              'Designer',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap.h8,
            InkWell(
              borderRadius: BorderRadius.circular(10.r),
              radius: 54.r,
              onTap: () async {
                final rating = await ref
                    .read(reviewControllerProvider.notifier)
                    .fetchRatingsByDesignerId(
                      product.designer!.id ?? '',
                    );

                ref
                    .read(goRouterProvider)
                    .pushNamed(Routes.designerProfile.name,
                        extra: Extras(datas: {
                          ExtrasKey.designer: product.designer,
                          ExtrasKey.rating: rating,
                          ExtrasKey.user: user
                        }));
              },
              child: Row(
                children: [
                  // Circle Image
                  product.imageUrl == '' || product.imageUrl == null
                      ? Assets.images.cozyLogo.image(
                          width: 48.w,
                          height: 48.h,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  // 'https://picsum.photos/200/300',
                                  product.designer!.photoUrl ??
                                      'https://picsum.photos/200/300'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  Gap.w12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Ahmad Joni',
                        product.designer!.name ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Desainer Pakaian',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  // action to chat or call with container had padding 8 and circle border with icon
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(50.r),
                    onTap: user?.role == 'designer'
                        ? () {}
                        : () async {
                            final String designerId =
                                product.designer!.id.toString();
                            final check = await ref
                                .read(chatControllerProvider.notifier)
                                .checkChat(
                                    usersId: ref
                                        .read(commonControllerProvider.notifier)
                                        .getUid(),
                                    contactId: designerId);
                            if (check) {
                              final messagesId = await ref
                                  .read(chatControllerProvider.notifier)
                                  .getMessagesId(
                                      usersId: ref
                                          .read(
                                              commonControllerProvider.notifier)
                                          .getUid(),
                                      contactId: designerId);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatDetailPage(
                                        usersId: designerId,
                                        messagesId: messagesId),
                                  ));
                            } else {
                              await ref
                                  .read(chatControllerProvider.notifier)
                                  .createChat(
                                    usersId: ref
                                        .read(commonControllerProvider.notifier)
                                        .getUid(),
                                    contactId: designerId,
                                  );

                              final messagesId = await ref
                                  .read(chatControllerProvider.notifier)
                                  .getMessagesId(
                                      usersId: ref
                                          .read(
                                              commonControllerProvider.notifier)
                                          .getUid(),
                                      contactId: designerId);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatDetailPage(
                                        usersId: designerId,
                                        messagesId: messagesId),
                                  ));
                            }
                          },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                        ),
                      ),
                      child: Icon(
                        Icons.chat,
                        color: ColorApp.primary,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  Gap.w8,
                  InkWell(
                    borderRadius: BorderRadius.circular(50.r),
                    onTap: user?.role == 'designer'
                        ? () {}
                        : () async {
                            String url =
                                'https://api.whatsapp.com/send/?phone=%2B62${product.designer?.phone}&text=Halo%20saya%20ingin%20bertanya%20tentang%20produk%20anda&type=phone_number&app_absent=0';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              throw 'Could not open the map.';
                            }
                          },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                        ),
                      ),
                      child: Icon(
                        Icons.call,
                        color: ColorApp.primary,
                        size: 18.sp,
                      ),
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
