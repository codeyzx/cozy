import 'package:chyess/src/shared/converter/epoch_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    String? id,
    String? userId,
    String? productId,
    double? rating,
    String? text,
    @EpochDateTimeConverter() DateTime? createdAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
