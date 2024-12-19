import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/auth/presentation/login/login_page.dart';
import 'package:chyess/src/features/auth/presentation/register/register_page.dart';
import 'package:chyess/src/features/auth/presentation/reset_password/reset_password_page.dart';
import 'package:chyess/src/features/chat/presentation/chat_detail_page.dart';
import 'package:chyess/src/features/chat/presentation/chat_page.dart';
import 'package:chyess/src/features/chat/presentation/consult_confirm_page.dart';
import 'package:chyess/src/features/chat/presentation/consult_page.dart';
import 'package:chyess/src/features/common/presentation/botnavbar/botnavbar_widget.dart';
import 'package:chyess/src/features/common/presentation/onboard/onboard_page.dart';
import 'package:chyess/src/features/common/presentation/profile/presentation/profile_edit_page.dart';
import 'package:chyess/src/features/common/presentation/profile/presentation/terms_and_conditions_page.dart';
import 'package:chyess/src/features/common/presentation/question/question_page.dart';
import 'package:chyess/src/features/common/presentation/splash/splash_page.dart';
import 'package:chyess/src/features/custom/presentation/custom_confirmation_page.dart';
import 'package:chyess/src/features/custom/presentation/custom_detail_page.dart';
import 'package:chyess/src/features/custom/presentation/custom_detail_personal_page.dart';
import 'package:chyess/src/features/order/presentation/order_confirm_page.dart';
import 'package:chyess/src/features/order/presentation/order_detail_page.dart';
import 'package:chyess/src/features/order/presentation/order_page.dart';
import 'package:chyess/src/features/product/presentation/ar/ar_page.dart';
import 'package:chyess/src/features/product/presentation/designer/designer_page.dart';
import 'package:chyess/src/features/product/presentation/designer/designer_profile_page.dart';
import 'package:chyess/src/features/product/presentation/product_confirmation_page.dart';
import 'package:chyess/src/features/product/presentation/product_detail_page.dart';
import 'package:chyess/src/features/product/presentation/product_manage_page.dart.dart';
import 'package:chyess/src/features/product/presentation/product_page.dart';
import 'package:chyess/src/features/product/presentation/search/search_page.dart';
import 'package:chyess/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_routes.g.dart';

enum Routes {
  splash,
  onboard,
  register,
  question,
  login,
  reset,
  botNavBar,
  chat,
  chatDetail,
  consult,
  consultConfirm,
  search,
  product,
  productDetail,
  productManage,
  designer,
  designerProfile,
  order,
  orderDetail,
  orderConfirm,
  profileEdit,
  tnc,
  customDetail,
  customDetailPersonal,
  customConfirmation,
  productConfirmation,
  ar,
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/splash',
    routerNeglect: true,
    redirectLimit: 1,
    routes: [
      GoRoute(
        path: '/splash',
        name: Routes.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboard',
        name: Routes.onboard.name,
        builder: (context, state) => const OnboardPage(),
      ),
      GoRoute(
        path: '/register',
        name: Routes.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      // question
      GoRoute(
        path: '/question',
        name: Routes.question.name,
        builder: (context, state) => const QuestionPage(),
      ),
      GoRoute(
        path: '/login',
        name: Routes.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/reset',
        name: Routes.reset.name,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: '/botNavBar',
        name: Routes.botNavBar.name,
        builder: (context, state) => const BotNavBarWidget(),
      ),
      // search
      GoRoute(
        path: '/search',
        name: Routes.search.name,
        builder: (context, state) => const SearchPage(),
      ),
      // product
      GoRoute(
        path: '/product',
        name: Routes.product.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final title = extras.datas[ExtrasKey.title];
          final products = extras.datas[ExtrasKey.products];
          return ProductPage(title: title, products: products);
        },
      ),
      // product detail
      GoRoute(
        path: '/productDetail',
        name: Routes.productDetail.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final product = extras.datas[ExtrasKey.product];
          final rating = extras.datas[ExtrasKey.rating];
          return ProductDetailPage(product: product, rating: rating);
        },
      ),
      // product manage
      GoRoute(
        path: '/productManage',
        name: Routes.productManage.name,
        builder: (context, state) {
          // final extras = state.extra as Extras;
          // final product = extras.datas[ExtrasKey.product];
          // final rating = extras.datas[ExtrasKey.rating];
          // return ProductDetailPage(product: product, rating: rating);
          return const ProductManagePage();
        },
      ),
      GoRoute(
        path: '/order',
        name: Routes.order.name,
        builder: (context, state) => const OrderPage(),
      ),
      // order detail
      GoRoute(
        path: '/orderDetail',
        name: Routes.orderDetail.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final order = extras.datas[ExtrasKey.order];
          return OrderDetailPage(order: order);
        },
      ),
      // order confirm
      GoRoute(
        path: '/orderConfirm',
        name: Routes.orderConfirm.name,
        builder: (context, state) {
          final extras = state.extra as Extras?;
          final order = extras?.datas[ExtrasKey.order];
          return OrderConfirmPage(order: order);
        },
      ),
      GoRoute(
        path: '/chat',
        name: Routes.chat.name,
        builder: (context, state) => const ChatPage(),
      ),
      // chat detail
      GoRoute(
        path: '/chatDetail',
        name: Routes.chatDetail.name,
        builder: (context, state) => const ChatDetailPage(),
      ),
      // consult
      GoRoute(
        path: '/consult',
        name: Routes.consult.name,
        builder: (context, state) => const ConsultPage(),
      ),
      GoRoute(
        path: '/consultConfirm',
        name: Routes.consultConfirm.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final order = extras.datas[ExtrasKey.order];
          return ConsultConfirmPage(order: order);
        },
      ),
      GoRoute(
        path: '/profileEdit',
        name: Routes.profileEdit.name,
        builder: (context, state) => const ProfileEditPage(),
      ),
      // tnc
      GoRoute(
        path: '/tnc',
        name: Routes.tnc.name,
        builder: (context, state) => const TermsAndConditionsPage(),
      ),
      GoRoute(
          path: '/designer',
          name: Routes.designer.name,
          builder: (context, state) {
            final extras = state.extra as Extras;
            final user = extras.datas[ExtrasKey.user];
            return DesignerPage(designers: user);
          }),
      GoRoute(
          path: '/designerProfile',
          name: Routes.designerProfile.name,
          builder: (context, state) {
            final extras = state.extra as Extras;
            final user = extras.datas[ExtrasKey.user];
            final designer = extras.datas[ExtrasKey.designer];
            final rating = extras.datas[ExtrasKey.rating];
            return rating == null
                ? DesignerProfilePage(user: user, designer: designer)
                : DesignerProfilePage(
                    user: user, designer: designer, rating: rating);
          }),
      GoRoute(
        path: '/customDetail',
        name: Routes.customDetail.name,
        builder: (context, state) => const CustomDetailPage(),
      ),
      GoRoute(
          path: '/customDetailPersonal',
          name: Routes.customDetailPersonal.name,
          builder: (context, state) {
            final extras = state.extra as Extras?;
            final product = extras?.datas[ExtrasKey.product];
            return CustomDetailPersonalPage(product: product);
          }),
      GoRoute(
        path: '/customConfirmation',
        name: Routes.customConfirmation.name,
        builder: (context, state) => const CustomConfirmationPage(),
      ),
      GoRoute(
          path: '/productConfirmation',
          name: Routes.productConfirmation.name,
          builder: (context, state) {
            final extras = state.extra as Extras;
            final product = extras.datas[ExtrasKey.product];
            return ProductConfirmationPage(product: product);
          }),
      GoRoute(
          path: '/ar',
          name: Routes.ar.name,
          builder: (context, state) {
            final extras = state.extra as Extras;
            final arUrl = extras.datas[ExtrasKey.arUrl];
            final title = extras.datas[ExtrasKey.title];
            return ArPage(arUrl: arUrl, title: title);
          }),
    ],
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
  );
}
