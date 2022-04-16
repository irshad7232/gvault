import 'package:get/get.dart';

import '../modules/add_file/bindings/add_file_binding.dart';
import '../modules/add_file/views/add_file_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/set_key/bindings/set_key_binding.dart';
import '../modules/set_key/views/set_key_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SET_KEY,
      page: () => SetKeyView(),
      binding: SetKeyBinding(),
    ),
    GetPage(
      name: _Paths.ADD_FILE,
      page: () => AddFileView(),
      binding: AddFileBinding(),
    ),
  ];
}
