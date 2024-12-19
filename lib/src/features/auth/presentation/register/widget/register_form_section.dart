import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/presentation/register/register_controller.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterFormSection extends ConsumerWidget {
  const RegisterFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Akun',
            style: TypographyApp.headline1.medium,
          ),
          Gap.h36,
          InputFormWidget(
            controller: state.nameController,
            hintText: 'Nama Lengkap',
            prefixSvgIcon: Assets.icons.icProfileForm,
            validator: validate,
          ),
          Gap.h16,
          InputFormWidget(
            controller: state.emailController,
            hintText: 'abc@gmail.com',
            prefixSvgIcon: Assets.icons.icEmail,
            validator: validateEmail,
          ),
          Gap.h16,
          DropdownWidget(
              prefixSvgIcon: Assets.icons.icRole,
              hintText: 'Pilih Role',
              items: const [
                DropdownMenuItem(
                  value: 'user',
                  child: Text('Pembeli'),
                ),
                DropdownMenuItem(
                  value: 'designer',
                  child: Text('Penjual'),
                ),
              ],
              value: state.roleValue,
              onChanged: controller.onRoleValueChanged),
          Gap.h16,
          InputFormWidget.password(
            controller: state.passwordController,
            hintText: 'Password Kamu',
            isObscure: state.isObscure,
            prefixSvgIcon: Assets.icons.icPassword,
            onObscureTap: controller.onObscureTap,
            validator: controller.validatePassword,
          ),
          Gap.h16,
          InputFormWidget.password(
            controller: state.passwordConfirmController,
            hintText: 'Konfirmasi Password',
            isObscure: state.isObscureConfirm,
            prefixSvgIcon: Assets.icons.icPassword,
            onObscureTap: controller.onObscureConfirmTap,
            validator: controller.validatePasswordConfirm,
          ),
        ],
      ),
    );
  }
}
