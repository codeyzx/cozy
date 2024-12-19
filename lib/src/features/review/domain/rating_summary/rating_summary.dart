import 'package:chyess/src/features/review/domain/rating/rating.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_summary.freezed.dart';
part 'rating_summary.g.dart';

@freezed
class RatingSummary with _$RatingSummary {
  const factory RatingSummary({
    int? counter,
    double? average,
    int? counterFiveStars,
    int? counterFourStars,
    int? counterThreeStars,
    int? counterTwoStars,
    int? counterOneStars,
    double? materialRating,
    double? sizeRating,
    double? colorRating,
    double? designerRating,
    List<Rating>? ratings,
  }) = _RatingSummary;

  factory RatingSummary.fromJson(Map<String, dynamic> json) =>
      _$RatingSummaryFromJson(json);

  static RatingSummary fromRatings(List<Rating> ratings) {
    final counter = ratings.length;
    final average = ratings.map((e) {
          return e.overallRating!;
        }).reduce((value, element) => value + element) /
        counter;
    final counterFiveStars = ratings
        .where((element) => element.overallRating!.toInt() == 5)
        .toList()
        .length;
    final counterFourStars = ratings
        .where((element) => element.overallRating!.toInt() == 4)
        .toList()
        .length;
    final counterThreeStars = ratings
        .where((element) => element.overallRating!.toInt() == 3)
        .toList()
        .length;
    final counterTwoStars = ratings
        .where((element) => element.overallRating!.toInt() == 2)
        .toList()
        .length;
    final counterOneStars = ratings
        .where((element) => element.overallRating!.toInt() == 1)
        .toList()
        .length;
    final materialRating = ratings
            .map((e) => e.materialRating!)
            .reduce((value, element) => value + element) /
        counter;
    final sizeRating = ratings
            .map((e) => e.sizeRating!)
            .reduce((value, element) => value + element) /
        counter;
    final colorRating = ratings
            .map((e) => e.colorRating!)
            .reduce((value, element) => value + element) /
        counter;
    final designerRating = ratings
            .map((e) => e.designerRating!)
            .reduce((value, element) => value + element) /
        counter;

    return RatingSummary(
      counter: counter,
      average: average,
      counterFiveStars: counterFiveStars,
      counterFourStars: counterFourStars,
      counterThreeStars: counterThreeStars,
      counterTwoStars: counterTwoStars,
      counterOneStars: counterOneStars,
      materialRating: double.parse(materialRating.toStringAsFixed(1)),
      sizeRating: double.parse(sizeRating.toStringAsFixed(1)),
      colorRating: double.parse(colorRating.toStringAsFixed(1)),
      designerRating: double.parse(designerRating.toStringAsFixed(1)),
      ratings: ratings,
    );
  }
}
