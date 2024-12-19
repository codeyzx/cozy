import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/order/presentation/widgets/order_tabview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPage extends ConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(ref: ref),
        body: OrderTabViewWidget(ref: ref),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Size get preferredSize => Size.fromHeight(56.h + 1.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        ref.read(commonControllerProvider).userValue.asData?.value.role !=
                'user'
            ? 'Pesanan Masuk'
            : 'Pesanan Saya',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20.sp,
        ),
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(
          height: 1.h,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
