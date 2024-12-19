import 'package:chyess/src/features/review/domain/rating/rating.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ReviewState {
  final AsyncValue<List<Rating>?> ratings;
  final AsyncValue<Rating?> rating;

  ReviewState({
    this.ratings = const AsyncLoading(),
    this.rating = const AsyncLoading(),
  });

  ReviewState copyWith({
    AsyncValue<List<Rating>?>? ratings,
    AsyncValue<Rating?>? rating,
  }) {
    return ReviewState(
      ratings: ratings ?? this.ratings,
      rating: rating ?? this.rating,
    );
  }
}
