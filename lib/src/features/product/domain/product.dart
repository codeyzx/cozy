import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? arUrl,
    String? category,
    String? materials,
    String? sizes,
    String? colors,
    User? designer,
    String? location,
    String? city,
    double? rating,
    int? price,
    int? qty,
    int? sold,
    bool? isArAvailable,
    bool? isFavorited,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
