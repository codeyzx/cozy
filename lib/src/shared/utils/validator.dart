import 'package:chyess/src/shared/extensions/extensions.dart';

String? validate(String? value, {String? message}) {
  if (value.isNullOrEmpty()) {
    return message ?? "Tidak boleh kosong";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value.isNullOrEmpty()) {
    return "Tidak boleh kosong";
  } else if (!value!.isEmailValid) {
    return "Email tidak valid";
  }
  return null;
}
