import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/presentation/login/login_controller.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(
            left: 15.w,
            top: 9.h,
            bottom: 8.h,
            right: 2.w,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: .5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 60.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column[Text 'Reset' with #3785FC, Text 'Password' with #001C34 (bold, 47 size)]

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset',
                  style: TextStyle(
                    color: const Color(0xFF3785FC),
                    fontSize: 53.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    color: const Color(0xFF001C34),
                    fontSize: 53.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Tolong masukkan email kamu \nuntuk melakukan reset password.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16.sp,
              ),
            ),
            Gap.h32,

            Text(
              'Email Kamu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            Gap.h12,
            InputFormWidget(
              controller: state.emailController,
              onChanged: (value) {},
              hintText: 'abc@gmail.com',
              prefixSvgIcon: Assets.icons.icEmail,
              validator: validateEmail,
            ),
            const SizedBox(height: 30),
            ButtonWidget.primary(
              text: 'RESET PASSWORD',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
