// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RatingImpl _$$RatingImplFromJson(Map json) => _$RatingImpl(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      materialRating: (json['materialRating'] as num?)?.toDouble(),
      sizeRating: (json['sizeRating'] as num?)?.toDouble(),
      colorRating: (json['colorRating'] as num?)?.toDouble(),
      designerRating: (json['designerRating'] as num?)?.toDouble(),
      designerId: json['designerId'] as String?,
      overallRating: (json['overallRating'] as num?)?.toDouble(),
      comment: json['comment'] == null
          ? null
          : Comment.fromJson(Map<String, dynamic>.from(json['comment'] as Map)),
    );

Map<String, dynamic> _$$RatingImplToJson(_$RatingImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('productId', instance.productId);
  writeNotNull('materialRating', instance.materialRating);
  writeNotNull('sizeRating', instance.sizeRating);
  writeNotNull('colorRating', instance.colorRating);
  writeNotNull('designerRating', instance.designerRating);
  writeNotNull('designerId', instance.designerId);
  writeNotNull('overallRating', instance.overallRating);
  writeNotNull('comment', instance.comment?.toJson());
  return val;
}
