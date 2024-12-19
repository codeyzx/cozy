// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RatingSummaryImpl _$$RatingSummaryImplFromJson(Map json) =>
    _$RatingSummaryImpl(
      counter: (json['counter'] as num?)?.toInt(),
      average: (json['average'] as num?)?.toDouble(),
      counterFiveStars: (json['counterFiveStars'] as num?)?.toInt(),
      counterFourStars: (json['counterFourStars'] as num?)?.toInt(),
      counterThreeStars: (json['counterThreeStars'] as num?)?.toInt(),
      counterTwoStars: (json['counterTwoStars'] as num?)?.toInt(),
      counterOneStars: (json['counterOneStars'] as num?)?.toInt(),
      materialRating: (json['materialRating'] as num?)?.toDouble(),
      sizeRating: (json['sizeRating'] as num?)?.toDouble(),
      colorRating: (json['colorRating'] as num?)?.toDouble(),
      designerRating: (json['designerRating'] as num?)?.toDouble(),
      ratings: (json['ratings'] as List<dynamic>?)
          ?.map((e) => Rating.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$RatingSummaryImplToJson(_$RatingSummaryImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('counter', instance.counter);
  writeNotNull('average', instance.average);
  writeNotNull('counterFiveStars', instance.counterFiveStars);
  writeNotNull('counterFourStars', instance.counterFourStars);
  writeNotNull('counterThreeStars', instance.counterThreeStars);
  writeNotNull('counterTwoStars', instance.counterTwoStars);
  writeNotNull('counterOneStars', instance.counterOneStars);
  writeNotNull('materialRating', instance.materialRating);
  writeNotNull('sizeRating', instance.sizeRating);
  writeNotNull('colorRating', instance.colorRating);
  writeNotNull('designerRating', instance.designerRating);
  writeNotNull('ratings', instance.ratings?.map((e) => e.toJson()).toList());
  return val;
}
