import 'dart:async';

import 'package:chatappfront/Api/services/shared_preferences.dart';
import 'package:chatappfront/pages/LoginScreen.dart';
import 'package:chatappfront/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      checkToken();
    });
    print(SharedServices.getData(SetType.string, 'token'));
    super.initState();
  }

  checkToken () async {
    final token = await SharedServices.getData(SetType.string, 'token');

    if (token != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/chatlogo.png', width: 150),
      ),
    );
  }
}
