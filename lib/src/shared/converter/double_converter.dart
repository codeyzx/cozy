import 'package:freezed_annotation/freezed_annotation.dart';

class DoubleConverter implements JsonConverter<double, dynamic> {
  const DoubleConverter();

  @override
  double fromJson(dynamic json) {
    if (json is num) {
      return json.toDouble();
    }
    return double.parse(json);
  }

  @override
  String toJson(double object) => object.toString();
}
