import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum InputFormType {
  normal,
  password,
  button,
  phone,
}

class InputFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String value)? onChanged;
  final bool isObscure;
  final IconData? prefixIcon;
  final SvgGenImage? prefixSvgIcon;
  final Function()? onObscureTap;
  final InputFormType inputFormType;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? errorText;
  final String? Function(String?)? validator;
  final bool? isHeight;
  final bool? isWeight;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? enabled;

  const InputFormWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.prefixSvgIcon,
    this.onChanged,
    this.errorText,
    this.validator,
    this.isHeight,
    this.isWeight,
    this.keyboardType,
    this.maxLines,
    this.enabled,
  })  : inputFormType = InputFormType.normal,
        isObscure = false,
        readOnly = false,
        onTap = null,
        onObscureTap = null;

  const InputFormWidget.button({
    super.key,
    required this.controller,
    required this.hintText,
    this.onTap,
    this.errorText,
    this.validator,
    this.keyboardType,
    this.prefixSvgIcon,
    this.enabled,
  })  : inputFormType = InputFormType.button,
        prefixIcon = null,
        isObscure = false,
        readOnly = true,
        onChanged = null,
        isHeight = null,
        isWeight = null,
        maxLines = 1,
        onObscureTap = null;

  const InputFormWidget.password({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.isObscure = true,
    this.onObscureTap,
    this.errorText,
    this.validator,
    this.keyboardType,
    this.prefixSvgIcon,
    this.enabled,
  })  : inputFormType = InputFormType.password,
        readOnly = false,
        isHeight = null,
        isWeight = null,
        maxLines = 1,
        onTap = null;

  const InputFormWidget.phone({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.onObscureTap,
    this.errorText,
    this.validator,
    this.keyboardType,
    this.prefixSvgIcon,
    this.enabled,
  })  : inputFormType = InputFormType.phone,
        readOnly = false,
        isHeight = null,
        isWeight = null,
        isObscure = false,
        maxLines = 1,
        onTap = null;

  bool get isPassword => inputFormType == InputFormType.password;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled ?? true,
      controller: controller,
      onChanged: onChanged,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      maxLines: maxLines ?? 1,
      style: TypographyApp.loginOnInput,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        errorText: errorText,
        hintText: hintText,
        hintStyle: TypographyApp.loginOffInput,
        disabledBorder: OutlineInputBorder(
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
        prefixIcon: inputFormType == InputFormType.phone
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 10.w),
                    alignment: Alignment.center,
                    child: Text(
                      '+62',
                      style: TypographyApp.text1.copyWith(
                        color: ColorApp.secondary.withOpacity(.3),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorApp.secondary.withOpacity(.3),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 1,
                    color: ColorApp.secondary.withOpacity(.3),
                  ),
                  const SizedBox(
                    height: 60,
                    width: 10,
                  ),
                ],
              )
            : prefixSvgIcon.isNotNull()
                ? Container(
                    height: 22,
                    width: 22,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    child: prefixSvgIcon!.svg(),
                  )
                : prefixIcon.isNotNull()
                    ? Icon(prefixIcon)
                    : null,
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: onObscureTap,
                child: isObscure
                    ? Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        child: Assets.icons.icHideOn.svg(
                          width: 35,
                          height: 35,
                        ),
                      )
                    : Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        child: Assets.icons.icHideOff.svg(
                          width: 35,
                          height: 35,
                        ),
                      ))
            : isHeight != null
                ? Container(
                    height: 53.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: ColorApp.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7.r),
                        bottomRight: Radius.circular(7.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'CM',
                        style: TypographyApp.text1.copyWith(
                          color: ColorApp.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : isWeight != null
                    ? Container(
                        height: 53.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: ColorApp.primary,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(7.r),
                            bottomRight: Radius.circular(7.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'KG',
                            style: TypographyApp.text1.copyWith(
                              color: ColorApp.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
      ),
      readOnly: readOnly,
      onTap: onTap,
    );
  }
}
