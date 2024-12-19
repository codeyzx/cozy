import 'package:chyess/src/features/review/domain/rating/rating.dart';
import 'package:chyess/src/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_repository.g.dart';

class ReviewRepository {
  final ratingDb =
      FirebaseFirestore.instance.collection('ratings').withConverter(
            fromFirestore: (snapshot, _) => Rating.fromJson(snapshot.data()!),
            toFirestore: (Rating rating, _) => rating.toJson(),
          );

  Future<Result<List<Rating>>> getRatingsByProductId(String productId) async {
    try {
      final resultRatings = await FirebaseFirestore.instance
          .collection('ratings')
          .where('productId', isEqualTo: productId)
          .get();
      List<Rating> ratings =
          resultRatings.docs.map((e) => Rating.fromJson(e.data())).toList();
      return Result.success(ratings);
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<List<Rating>>> getRatingsByDesignerId(String designerId) async {
    try {
      final resultRatings =
          await ratingDb.where('designerId', isEqualTo: designerId).get();
      final ratings = resultRatings.docs.map((e) => e.data()).toList();
      return Result.success(ratings);
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addRating(Rating rating) async {
    try {
      final ref = ratingDb.doc();
      rating = rating.copyWith(id: ref.id);
      await ref.set(rating);
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addRatings() async {
    try {
      List<Map<String, Object>> listRating = [
        {
          "id": "rating1",
          "productId": "1NvJVObkEdDuEvrzUxUX",
          "materialRating": 4.5,
          "sizeRating": 4.0,
          "colorRating": 4.7,
          "designerRating": 4.8,
          "designerId": "designer1",
          "overallRating": 4.5,
          "comment": {
            "id": "comment1",
            "userId": "user1",
            "productId": "1NvJVObkEdDuEvrzUxUX",
            "rating": 4.5,
            "text":
                "Saya sangat puas dengan desainnya! Bahan yang digunakan sangat berkualitas dan nyaman saat dipakai. Pelayanan dari desainer juga ramah dan profesional. Terima kasih!",
            "createdAt": 1743258800000000
          }
        },
        {
          "id": "rating2",
          "productId": "7b1z9Fd30bxJA0yMKoqx",
          "materialRating": 4.8,
          "sizeRating": 4.2,
          "colorRating": 4.9,
          "designerRating": 5.0,
          "designerId": "designer2",
          "overallRating": 4.7,
          "comment": {
            "id": "comment2",
            "userId": "user2",
            "productId": "7b1z9Fd30bxJA0yMKoqx",
            "rating": 4.8,
            "text":
                "Desainnya sungguh menakjubkan! Warna dan ukurannya pas dengan ekspektasi saya. Saya sangat merekomendasikan produk ini kepada semua orang.",
            "createdAt": 1743345300000000
          }
        },
        {
          "id": "rating3",
          "productId": "Ba76GMnwucFIhFUu9JTQ",
          "materialRating": 4.0,
          "sizeRating": 4.5,
          "colorRating": 4.3,
          "designerRating": 4.6,
          "designerId": "designer3",
          "overallRating": 4.3,
          "comment": {
            "id": "comment3",
            "userId": "user3",
            "productId": "Ba76GMnwucFIhFUu9JTQ",
            "rating": 4.3,
            "text":
                "Produknya cukup baik. Desainnya menarik dan ukurannya pas. Namun, saya berharap bahan yang digunakan sedikit lebih berkualitas.",
            "createdAt": 1743431800000000
          }
        },
        {
          "id": "rating4",
          "productId": "Ceu89bH4AjSD7YcLbAZi",
          "materialRating": 3.9,
          "sizeRating": 4.1,
          "colorRating": 4.0,
          "designerRating": 4.3,
          "designerId": "designer4",
          "overallRating": 4.1,
          "comment": {
            "id": "comment4",
            "userId": "user4",
            "productId": "Ceu89bH4AjSD7YcLbAZi",
            "rating": 4.1,
            "text":
                "Desainnya bagus, tetapi saya merasa bahan yang digunakan kurang nyaman saat dipakai untuk waktu yang lama. Pengiriman pun agak lambat.",
            "createdAt": 1743518300000000
          }
        },
        {
          "id": "rating5",
          "productId": "D2B7OSX7GryH0ZsMRobU",
          "materialRating": 4.2,
          "sizeRating": 4.4,
          "colorRating": 4.5,
          "designerRating": 4.7,
          "designerId": "designer5",
          "overallRating": 4.5,
          "comment": {
            "id": "comment5",
            "userId": "user5",
            "productId": "D2B7OSX7GryH0ZsMRobU",
            "rating": 4.5,
            "text":
                "Saya sangat senang dengan produk ini! Desainnya sangat menarik dan bahan yang digunakan sangat berkualitas. Saya akan membeli lagi di masa depan!",
            "createdAt": 1743604800000000
          }
        },
        {
          "id": "rating6",
          "productId": "FXBWdV4aGneJXN9jXdJe",
          "materialRating": 4.6,
          "sizeRating": 4.3,
          "colorRating": 4.8,
          "designerRating": 4.9,
          "designerId": "designer6",
          "overallRating": 4.7,
          "comment": {
            "id": "comment6",
            "userId": "user6",
            "productId": "FXBWdV4aGneJXN9jXdJe",
            "rating": 4.7,
            "text":
                "Produk ini benar-benar mengagumkan! Desainnya sangat unik dan warnanya sangat cocok dengan selera saya. Terima kasih kepada desainer yang sudah membuat produk yang luar biasa ini.",
            "createdAt": 1743691300000000
          }
        },
        {
          "id": "rating7",
          "productId": "GjIhQSVK0M5uk4Lz1KmH",
          "materialRating": 4.1,
          "sizeRating": 4.0,
          "colorRating": 4.3,
          "designerRating": 4.4,
          "designerId": "designer7",
          "overallRating": 4.2,
          "comment": {
            "id": "comment7",
            "userId": "user7",
            "productId": "GjIhQSVK0M5uk4Lz1KmH",
            "rating": 4.2,
            "text":
                "Produk ini ok. Tidak ada yang istimewa. Bahan sedikit murahan dan ukuran tidak sesuai dengan yang saya harapkan. Pengalaman belanja saya kali ini sedikit mengecewakan.",
            "createdAt": 1743777800000000
          }
        },
        {
          "id": "rating8",
          "productId": "JbdteU4WltJ2n5bMmJGA",
          "materialRating": 4.7,
          "sizeRating": 4.8,
          "colorRating": 4.9,
          "designerRating": 5.0,
          "designerId": "designer8",
          "overallRating": 4.9,
          "comment": {
            "id": "comment8",
            "userId": "user8",
            "productId": "JbdteU4WltJ2n5bMmJGA",
            "rating": 4.9,
            "text":
                "Luar biasa! Produk ini melebihi ekspektasi saya. Desainnya indah dan bahan yang digunakan sangat premium. Layanan dari desainer juga sangat baik. Saya sangat merekomendasikan produk ini kepada semua orang!",
            "createdAt": 1743864300000000
          }
        },
        {
          "id": "rating9",
          "productId": "NKIeb6QoA3FOPyxtahXO",
          "materialRating": 4.3,
          "sizeRating": 4.5,
          "colorRating": 4.4,
          "designerRating": 4.6,
          "designerId": "designer9",
          "overallRating": 4.5,
          "comment": {
            "id": "comment9",
            "userId": "user9",
            "productId": "NKIeb6QoA3FOPyxtahXO",
            "rating": 4.5,
            "text":
                "Desainnya cukup menarik, tetapi bahan yang digunakan agak tipis. Saya harap produk ini lebih tahan lama.",
            "createdAt": 1743950800000000
          }
        },
        {
          "id": "rating10",
          "productId": "NiSNrsD1Oyg3kDgk1Xod",
          "materialRating": 4.2,
          "sizeRating": 4.2,
          "colorRating": 4.1,
          "designerRating": 4.4,
          "overallRating": 4.2,
          "comment": {
            "id": "comment10",
            "userId": "user10",
            "productId": "NiSNrsD1Oyg3kDgk1Xod",
            "rating": 4.1,
            "text":
                "Desainnya lumayan bagus, tetapi bahan yang digunakan kurang nyaman di kulit. Saya harap produk ini bisa lebih baik lagi untuk harga yang saya bayar.",
            "createdAt": 1744037300000000
          }
        },
        {
          "id": "rating11",
          "productId": "UHp9iE7D9dlHCzkULegG",
          "materialRating": 3.8,
          "sizeRating": 3.9,
          "colorRating": 4.0,
          "designerRating": 4.1,
          "overallRating": 3.9,
          "comment": {
            "id": "comment11",
            "userId": "user11",
            "productId": "UHp9iE7D9dlHCzkULegG",
            "rating": 3.9,
            "text":
                "Saya cukup kecewa dengan produk ini. Desainnya tidak sebagus yang saya harapkan dan bahan yang digunakan terasa murahan. Pengiriman juga agak lambat.",
            "createdAt": 1744123800000000
          }
        },
        {
          "id": "rating12",
          "productId": "UeDQcR4zD8FikiR4wvYg",
          "materialRating": 1.9,
          "sizeRating": 2.1,
          "colorRating": 2.0,
          "designerRating": 2.3,
          "overallRating": 2.0,
          "comment": {
            "id": "comment12",
            "userId": "user12",
            "productId": "UeDQcR4zD8FikiR4wvYg",
            "rating": 2.0,
            "text":
                "Saya sangat menyesal membeli produk ini. Desainnya tidak sesuai dengan harapan saya sama sekali. Bahan yang digunakan terasa tidak nyaman dan pengiriman pun sangat lambat. Saya tidak merekomendasikan produk ini kepada siapa pun.",
            "createdAt": 1744210300000000
          }
        },
        {
          "id": "rating13",
          "productId": "XObMECjb4S4MT0wP72pf",
          "materialRating": 2.5,
          "sizeRating": 2.3,
          "colorRating": 2.4,
          "designerRating": 2.6,
          "overallRating": 2.4,
          "comment": {
            "id": "comment13",
            "userId": "user13",
            "productId": "XObMECjb4S4MT0wP72pf",
            "rating": 2.4,
            "text":
                "Saya kecewa dengan produk ini. Desainnya tidak menarik dan bahan yang digunakan terasa sangat murahan. Ukurannya juga tidak sesuai dengan yang saya harapkan. Saya tidak akan membeli produk dari desainer ini lagi.",
            "createdAt": 1744296800000000
          }
        },
        {
          "id": "rating14",
          "productId": "bXz2jgGsCnAzJeC6Hr2V",
          "materialRating": 3.1,
          "sizeRating": 3.0,
          "colorRating": 3.2,
          "designerRating": 3.3,
          "overallRating": 3.1,
          "comment": {
            "id": "comment14",
            "userId": "user14",
            "productId": "bXz2jgGsCnAzJeC6Hr2V",
            "rating": 3.1,
            "text":
                "Produk ini biasa saja. Bahan dan desainnya standar. Saya merasa tidak ada yang istimewa dari produk ini. Pengiriman juga tidak begitu cepat.",
            "createdAt": 1744383300000000
          }
        }
      ];

      List<Rating> ratings = listRating.map((e) => Rating.fromJson(e)).toList();
      for (var rating in ratings) {
        // Logger().i(rating);
        final ref = ratingDb.doc();
        rating = rating.copyWith(id: ref.id);
        await ref.set(rating);
      }

      return const Result.success('Success');
    } catch (e) {
      // Logger().e(e);

      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
ReviewRepository reviewRepository(ReviewRepositoryRef ref) {
  return ReviewRepository();
}
