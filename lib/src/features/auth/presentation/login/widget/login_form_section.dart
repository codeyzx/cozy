import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/presentation/login/login_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/shared/extensions/extensions.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginFormSection extends ConsumerWidget {
  const LoginFormSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Masuk',
            style: TypographyApp.headline1.medium,
          ),
          Gap.h20,
          InputFormWidget(
            controller: state.emailController,
            hintText: 'abc@gmail.com',
            prefixSvgIcon: Assets.icons.icEmail,
            validator: validateEmail,
          ),
          Gap.h16,
          InputFormWidget.password(
            controller: state.passwordController,
            hintText: 'Password Kamu',
            isObscure: state.isObscure,
            prefixSvgIcon: Assets.icons.icPassword,
            onObscureTap: controller.onObscureTap,
            validator: controller.validatePassword,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  context.pushNamed(Routes.reset.name);
                },
                child: Text(
                  'Lupa Password?',
                  style: TypographyApp.text1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
