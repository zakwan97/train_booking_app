import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/routes/app_pages.dart';
import 'package:train_booking_app/util/preference.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLogin = Preference.getBool(Preference.isLogin)!;

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.apple.com')
          .timeout(const Duration(seconds: 10));
      if (response.isNotEmpty) {
        redirectPage(2);
      }
    } catch (error) {
      print(error);
    }
  }

  redirectPage(int duration) {
    Timer(Duration(seconds: duration), () {
      isLogin
          ? Get.offNamed(AppPages.homePage)
          : Get.offNamed(AppPages.loginIn);
    });
  }

  @override
  void initState() {
    _checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/train_image.png',
              height: 200,
              width: 200,
            ),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: LinearProgressIndicator(
                color: Colors.red,
                backgroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
