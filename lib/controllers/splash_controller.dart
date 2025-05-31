import 'dart:async';
import 'package:get/get.dart';

import 'package:productapp/controllers/propertyController.dart';


class SplashController extends GetxController {
  //final userInfo = GetStorage();
  PropertyController PropertyController1 =
      Get.put(PropertyController());

  @override
  void onReady() {
    afterSplash();
    super.onReady();
  }

  void afterSplash() {
    Timer(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  checkLoginStatus() {
    // print(userInfo.read('token'));
      Get.toNamed('/welcomePage');

  }
}
