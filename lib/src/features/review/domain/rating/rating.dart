import 'package:chyess/src/features/review/domain/comment/comment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating.freezed.dart';
part 'rating.g.dart';

@freezed
class Rating with _$Rating {
  const factory Rating({
    String? id,
    String? productId,
    double? materialRating,
    double? sizeRating,
    double? colorRating,
    double? designerRating,
    String? designerId,
    double? overallRating,
    Comment? comment,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}
