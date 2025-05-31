import 'package:get/get.dart';
import 'package:productapp/controllers/propertyController.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PropertyController());
  }
}
