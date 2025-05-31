import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productapp/views/main_page.dart';
import 'package:toggle_switch/toggle_switch.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  XFile? image;
  File? galleryFile;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    double s = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleSwitch(
                        minWidth: 90.0,
                        initialLabelIndex: mode == ThemeMode.dark ? 0 : 1,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: const ['Dark', 'Light'],
                        activeBgColors: const [
                          [Colors.blue],
                          [Colors.pink],
                        ],
                        onToggle: (int? index) {
                          if (index != null) {
                            _notifier.value =
                            index == 0 ? ThemeMode.dark : ThemeMode.light;
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      Image.asset('assets/images/gnblogo.png', height: 120),
                      const SizedBox(height: 40),
                      const Text(
                        'Welcome to Product App',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Let\'s get started with exploring!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/homePage');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>  MainPage()),
                          // );
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
