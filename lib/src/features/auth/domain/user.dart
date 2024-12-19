import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? role,
    String? status,
    String? phone,
    String? address,
    String? city,
    String? description,
    double? rating,
    bool? isArAvailable,
    bool? isSuccessRegister,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
