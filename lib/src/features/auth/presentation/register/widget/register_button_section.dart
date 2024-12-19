import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/features/auth/presentation/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterButtonSection extends ConsumerWidget {
  const RegisterButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonWidget.primary(
          text: 'DAFTAR',
          onTap: controller.register,
          // onTap: () {
          //   context.pushNamed(Routes.question.name);
          // },
          isLoading: state.isLoading,
        ),
      ],
    );
  }
}
