import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/presentation/register/register_controller.dart';
import 'package:chyess/src/features/auth/presentation/register/widget/button_sign_with_google.dart';
import 'package:chyess/src/features/auth/presentation/register/widget/divider_with_text_widget.dart';
import 'package:chyess/src/features/auth/presentation/register/widget/register_button_section.dart';
import 'package:chyess/src/features/auth/presentation/register/widget/register_form_section.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/features/product/presentation/product_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(registerControllerProvider, (prevState, state) {
      if (prevState?.registerValue != state.registerValue) {
        state.registerValue.whenOrNull(
          data: (data) async {
            await ref.read(commonControllerProvider.notifier).getProfile();
            final user =
                ref.read(commonControllerProvider).userValue.asData?.value;
            await ref.read(productControllerProvider.notifier).fetchProducts();
            await ref.read(commonControllerProvider.notifier).fetchDesigners();
            await ref.read(orderControllerProvider.notifier).fetchOrders(
                  user?.role ?? '',
                  user?.id ?? '',
                );

            ref.read(commonControllerProvider.notifier).setPage(0);
            ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
          },
          error: (error, stackTrace) {
            final message =
                NetworkExceptions.getErrorMessage(error as NetworkExceptions);
            appSnackBar(context, ColorApp.red, message);
          },
        );
      }
    });

    return StatusBarWidget(
      brightness: Brightness.dark,
      child: Scaffold(
        body: SingleChildScrollView(
          child: PaddingWidget(
            child: Column(
              children: [
                Gap.h80,
                const RegisterFormSection(),
                Gap.h32,
                const RegisterButtonSection(),
                Gap.h20,
                const DividerWithText(text: 'Atau'),
                Gap.h20,
                const ButtonSignWithGoogle(
                  text: 'Daftar dengan Google',
                ),
                Gap.h56,
                const BottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sudah punya akun? ',
          style: TypographyApp.headline3,
        ),
        Gap.w8,
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            context.pop();
          },
          child: Text(
            'Masuk',
            style: TypographyApp.headline3.copyWith(
              color: ColorApp.primary,
            ),
          ),
        ),
      ],
    );
  }
}
