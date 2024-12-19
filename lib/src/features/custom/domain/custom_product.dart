import 'package:chyess/src/shared/converter/epoch_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_product.freezed.dart';
part 'custom_product.g.dart';

@freezed
class CustomProduct with _$CustomProduct {
  const factory CustomProduct({
    String? id,
    String? name,
    String? imageUrl,
    String? material,
    String? size,
    String? color,
    int? qty,
    double? price,
    @EpochDateTimeConverter() DateTime? createdAt,
  }) = _CustomProduct;

  factory CustomProduct.fromJson(Map<String, dynamic> json) =>
      _$CustomProductFromJson(json);
}
