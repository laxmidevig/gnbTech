
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:productapp/controllers/propertyController.dart';
import 'package:productapp/controllers/splash_controller.dart';


class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  PropertyController propertyController = Get.put(PropertyController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              toolbarHeight: 1,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                          width: 150,
                          height: 150,
                          'assets/images/gnblogo.png')),
                  const SizedBox(height: 20),
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.green,
                    size: 80,
                  ),
                  // SpinKitCircle(
                  //     color: Theme.of(context).primaryColor,
                  //     duration: const Duration(seconds: 3))
                ],
              ),
            ),
          );
        });
  }
}
