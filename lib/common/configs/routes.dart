import 'package:get/get.dart';
import 'package:eofficeapp/modules/auth/presentation/dc_change_password.dart';
import 'package:eofficeapp/modules/auth/presentation/dc_forgot_password_page.dart';
import 'package:eofficeapp/modules/auth/presentation/dc_forgot_password_verify_page.dart';
import 'package:eofficeapp/modules/auth/presentation/dc_login_page.dart';
import 'package:eofficeapp/modules/auth/presentation/dc_signup_page_new.dart';
import 'package:eofficeapp/modules/maintab/presentation/maintab_page.dart';
import 'package:eofficeapp/modules/splash/presentation/splash_page.dart';

final idKantor = Get.arguments['idKantor'];

final routes = [
  GetPage(
    name: '/splash',
    page: () => const SplashPage(),
  ),
  GetPage(
    name: '/',
    page: () => const MainTabPage(),
  ),
  // auth routes
  GetPage(
    name: '/login',
    page: () => const DCLoginPage(),
  ),
  GetPage(
    name: '/signup',
    page: () => const DCSignupPageNew(),
  ),
  GetPage(
    name: '/forgot_password',
    page: () => const DCForgotPasswordPage(),
  ),
  GetPage(
    name: '/forgot_password_verify',
    page: () => const DCForgotPasswordVerifyPage(),
  ),
  GetPage(
    name: '/change_password',
    page: () => const DCChangePassword(),
  ),
];
