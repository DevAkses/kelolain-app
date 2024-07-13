import 'package:get/get.dart';

import '../modules/forgot_password_page/bindings/forgot_password_page_binding.dart';
import '../modules/forgot_password_page/views/forgot_password_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_artikel_page/bindings/list_artikel_page_binding.dart';
import '../modules/list_artikel_page/views/list_artikel_page_view.dart';
import '../modules/list_video_page/bindings/list_video_page_binding.dart';
import '../modules/list_video_page/views/list_video_page_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/read_artikel_edukasi/bindings/read_artikel_edukasi_binding.dart';
import '../modules/read_artikel_edukasi/views/read_artikel_edukasi_view.dart';
import '../modules/read_video_edukasi/bindings/read_video_edukasi_binding.dart';
import '../modules/read_video_edukasi/views/read_video_edukasi_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';
import '../modules/tab_edukasi/bindings/tab_edukasi_binding.dart';
import '../modules/tab_edukasi/views/tab_edukasi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TAB_EDUKASI,
      page: () => const TabEdukasiView(),
      binding: TabEdukasiBinding(),
    ),
    GetPage(
      name: _Paths.READ_ARTIKEL_EDUKASI,
      page: () => const ReadArtikelEdukasiView(),
      binding: ReadArtikelEdukasiBinding(),
    ),
    GetPage(
      name: _Paths.READ_VIDEO_EDUKASI,
      page: () => const ReadVideoEdukasiView(),
      binding: ReadVideoEdukasiBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_PAGE,
      page: () => const ForgotPasswordPageView(),
      binding: ForgotPasswordPageBinding(),
    ),
    GetPage(
      name: _Paths.LIST_ARTIKEL_PAGE,
      page: () => const ListArtikelPageView(),
      binding: ListArtikelPageBinding(),
    ),
    GetPage(
      name: _Paths.LIST_VIDEO_PAGE,
      page: () => const ListVideoPageView(),
      binding: ListVideoPageBinding(),
    ),
  ];
}
