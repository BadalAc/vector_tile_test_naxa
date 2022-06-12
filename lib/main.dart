import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vector_tile_test_naxa/routes.dart';

Future<void> main() async {
  runApp(
    const SoloSellApp(
      isLoggedIn: true,
    ),
  );
}

class SoloSellApp extends StatelessWidget {
  const SoloSellApp({Key? key, required this.isLoggedIn}) : super(key: key);
  final bool isLoggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Naxa App',
      theme: ThemeData(
        fontFamily: 'ProductSans',
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white54,
      ),
      initialRoute: Routes.mapPage,
      getPages: Routes.routes,
    );
  }
}
