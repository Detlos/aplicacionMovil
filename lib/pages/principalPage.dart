import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integradora/pages/loginPage.dart';
import 'package:integradora/pages/registroPage.dart';

class PrincipalPage extends StatelessWidget {
  TextStyle estilo = TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff011e30),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'DETLOSAPP',
            style: TextStyle(
                fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 100),
          Row(
            children: [
              Expanded(
                  child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Registrarse',
                        style: estilo,
                      ),
                      onPressed: () {
                        Get.to(RegistroPage(), transition: Transition.fade);
                      })),
              SizedBox(width: 5),
              Expanded(
                  child: RaisedButton(
                      child: Text('Inicia sesion'),
                      onPressed: () {
                        Get.to(LoginPage(), transition: Transition.fade);
                      })),
              SizedBox(height: 250)
            ],
          )
        ],
      ),
    );
  }
}
