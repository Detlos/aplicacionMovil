import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integradora/pages/loginPage.dart';
import 'package:integradora/pages/principalPage.dart';
import 'package:integradora/pages/registroPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => PrincipalPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/registro', page: () => RegistroPage()),
      ],
    );
  }
}
