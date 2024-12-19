import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownWidget<T> extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T? value)? onChanged;
  final SvgGenImage? prefixSvgIcon;
  final TextStyle? style;
  const DropdownWidget({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.prefixSvgIcon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorApp.secondary.withOpacity(0.3),
            width: 1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorApp.secondary.withOpacity(0.3),
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: ColorApp.primary,
            width: 2.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: ColorApp.red,
            width: 2.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: ColorApp.red,
            width: 2.w,
          ),
        ),
        prefixIcon: prefixSvgIcon.isNotNull()
            ? Container(
                height: 22,
                width: 22,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: prefixSvgIcon!.svg(),
              )
            : null,
      ),
      isEmpty: value == null || value == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
            items: items,
            onChanged: onChanged,
            isDense: true,
            style: TypographyApp.text1,
            value: value,
            hint: Text(
              hintText,
              style: style ?? TypographyApp.loginOffInput,
            )),
      ),
    );
  }
}
