import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/pages/home/home_controller.dart';

class HomePage extends StatelessWidget {
  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () => con.logOut(),
        child: const Text("Cerrar Sesion",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    ));
  }
}
