// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:integradora/pages/loginPage.dart';
// import 'package:integradora/pages/registroPage.dart';

// class PrincipalPage extends StatelessWidget {
//   TextStyle estilo = TextStyle(color: Colors.white);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff011e30),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(
//             'DETLOSAPP',
//             style: TextStyle(
//                 fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 100),
//           Row(
//             children: [
//               Expanded(
//                   child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.blue, // background
//                       ),
//                       child: Text(
//                         'Registrarse',
//                         style: estilo,
//                       ),
//                       onPressed: () {
//                         Get.to(RegisterPage(), transition: Transition.size);
//                       })),
//               SizedBox(width: 5),
//               Expanded(
//                   child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(primary: Colors.grey),
//                       child: Text('Inicia sesion'),
//                       onPressed: () {
//                         Get.to(LoginPage(), transition: Transition.size);
//                       })),
//               SizedBox(height: 250)
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
