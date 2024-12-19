import 'package:chyess/src/features/review/data/review_repository.dart';
import 'package:chyess/src/features/review/domain/rating/rating.dart';
import 'package:chyess/src/features/review/domain/rating_summary/rating_summary.dart';
import 'package:chyess/src/features/review/presentation/review_state.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_controller.g.dart';

@riverpod
class ReviewController extends _$ReviewController {
  @override
  ReviewState build() {
    // fetchRatings();
    return ReviewState();
  }

  // Future<void> fetchRatings() async {
  //   final result = await ref.read(reviewRepositoryProvider).getRatings();
  //   result.when(
  //     success: (reviews) {
  //       state = state.copyWith(
  //         ratings: AsyncData(reviews),
  //       );
  //     },
  //     failure: (e, s) {
  //       state = state.copyWith(ratings: AsyncError(e, s));
  //     },
  //   );
  // }

  FutureOr<RatingSummary?> fetchRatingsByProductId(String productId) async {
    final result = await ref
        .read(reviewRepositoryProvider)
        .getRatingsByProductId(productId);
    return result.when(
      success: (reviews) {
        return reviews.isEmpty ? null : RatingSummary.fromRatings(reviews);
      },
      failure: (e, s) {
        Logger().e('Error on fetchRatingsByProductId: $e $s');
        return null;
      },
    );
  }

  FutureOr<RatingSummary?> fetchRatingsByDesignerId(String designerId) async {
    final result = await ref
        .read(reviewRepositoryProvider)
        .getRatingsByDesignerId(designerId);
    return result.when(
      success: (reviews) {
        return reviews.isEmpty ? null : RatingSummary.fromRatings(reviews);
      },
      failure: (e, s) {
        Logger().e('Error on fetchRatingsByProductId: $e $s');
        return null;
      },
    );
  }

  // Future<void> fetchRating(String id) async {
  //   final result = await ref.read(reviewRepositoryProvider).getRating(id);
  //   result.when(
  //     success: (rating) {
  //       state = state.copyWith(rating: AsyncData(rating));
  //     },
  //     failure: (e, s) {
  //       state = state.copyWith(rating: AsyncError(e, s));
  //     },
  //   );
  // }

  Future<void> addRating(Rating rating) async {
    final result = await ref.read(reviewRepositoryProvider).addRating(rating);
    result.when(
      success: (_) {
        // fetchRatings();
      },
      failure: (e, s) {
        Logger().e('Error on addRating: $e $s');
        // state = state.copyWith(ratings: AsyncError(e, s));
      },
    );
  }

  Future<void> addRatings() async {
    await ref.read(reviewRepositoryProvider).addRatings();
  }

  // // addcoments
  // Future<void> addComments() async {
  //   await ref.read(reviewRepositoryProvider).addComments();
  // }

  // Future<void> addComment(String ratingId, Comment comment) async {
  //   final result =
  //       await ref.read(reviewRepositoryProvider).addComment(ratingId, comment);
  //   result.when(
  //     success: (_) {
  //       fetchRating(ratingId);
  //     },
  //     failure: (e, s) {
  //       state = state.copyWith(rating: AsyncError(e, s));
  //     },
  //   );
  // }
}
