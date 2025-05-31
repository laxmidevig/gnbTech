import 'package:get/get.dart';
import 'package:productapp/bindings/app.dart';
import 'package:productapp/views/imagePic.dart';
import 'package:productapp/views/main_page.dart';
import 'package:productapp/views/splash_screen.dart';
import 'package:productapp/views/welcomePage.dart';


class AppRoutes {
  static const homePage = '/';
  static const splashPage = '/splashPage';
  static const welcomePage = '/welcomePage';

  static const imagePic = '/imagePic';

  static final routes = [
    GetPage(name: homePage, page: () => MainPage(), binding: AppBinding()),
    GetPage(name: splashPage, page: () => const SplashScreen1()),
    GetPage(name: welcomePage, page: () =>  WelcomePage()),
    GetPage(name: imagePic, page: () =>  ImagePickerPage()),
  ];
}
