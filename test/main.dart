import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/pages/login/login_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Delivery Udemy ",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => LoginPage())],
      theme: ThemeData(
          primaryColor: Colors.amber,
          colorScheme:  const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.amber,
              onPrimary: Colors.grey,
              secondary: Colors.amberAccent,
              onSecondary: Colors.grey,
              error: Colors.grey,
              onError: Colors.grey,
              background: Colors.grey,
              onBackground: Colors.grey,
              surface: Colors.grey,
              onSurface: Colors.grey)),
      navigatorKey: Get.key,
    );
  }
}
