// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:logsheet_turbin/screens/page/card_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class DetailPage2 extends StatefulWidget {
//   const DetailPage2({super.key});

//   @override
//   State<DetailPage2> createState() => _DetailPage2();
// }

// class _DetailPage2 extends State<DetailPage2> {
//   bool isDataSaved = false;
//   final TextEditingController turbinSpeedController = TextEditingController();
//   final TextEditingController rotorVibMonitorController = TextEditingController();
//   final TextEditingController axialDisplacementMonitorController = TextEditingController();
//   final TextEditingController mainSteamController = TextEditingController();
//   final TextEditingController stageSteamController = TextEditingController();
//   final TextEditingController exhaustController = TextEditingController();
//   final TextEditingController lubOilController = TextEditingController();
//   final TextEditingController controlOilController = TextEditingController();

//   void addData() async {
//     //request add
//     final pref = await SharedPreferences.getInstance();
//     final token = pref.getString('token');
//     Map body = {
//       'turbin_speed': turbinSpeedController.text,
//       'rotor_vib_monitor': rotorVibMonitorController.text,
//       'axial_displacement_monitor': axialDisplacementMonitorController.text,
//       'main_steam': mainSteamController.text,
//       'stage_steam': stageSteamController.text,
//       'exhaust': exhaustController.text,
//       'lub_oil': lubOilController.text,
//       'control_oil': controlOilController.text,
//     };
//     final response = await http.post(
//       Uri.parse('http://192.168.21.107:8000/api/input2'),
//       body: jsonEncode(body),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );
//     print(response.statusCode);
//     print(response.body);
//     if (response.statusCode == 200) {
//       setState(() {
//         isDataSaved = true;
//       });
//       // ignore: use_build_context_synchronously
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => const CardPage(),
//         ),
//       );
//     } else {
//       final jsonResponse = json.decode(response.body);
//       print(jsonResponse);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PAGE 2'),
//         titleTextStyle: const TextStyle(
//           fontSize: 18,
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 25,
//                 width: 25,
//               ),

//               // Turbin Speed
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Turbin Speed (RPM)",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 238, 241),
//                   borderRadius: BorderRadius.circular(10.0),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
//                     width: 1.0, // Ketebalan garis tepi
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15,
//                   ),
//                   child: TextFormField(
//                     controller: turbinSpeedController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               // Rotor Vibration Monitor
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Rotor Vibration Monitor (mm)",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 238, 241),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
//                     width: 1.0, // Ketebalan garis tepi
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 15,
//                   ),
//                   child: TextFormField(
//                     controller: rotorVibMonitorController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               // Axial Displace Ment Monitor
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Axial Displace Ment Monitor (mm)",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 238, 241),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
//                     width: 1.0, // Ketebalan garis tepi
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 15,
//                   ),
//                   child: TextFormField(
//                     controller: axialDisplacementMonitorController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               // Main Steam
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Main Steam (Kg/Cm\u00B2G)",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 238, 241),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
//                     width: 1.0, // Ketebalan garis tepi
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 15,
//                   ),
//                   child: TextFormField(
//                     controller: mainSteamController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               // 1ST Stage Steam
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "1ST Stage Steam (Kg/Cm\u00B2G)",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 238, 241),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
//                     width: 1.0, // Ketebalan garis tepi
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 15,
//                   ),
//                   child: TextFormField(
//                     controller: stageSteamController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               // Exhaust
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Exhaust (Kg/Cm\u00B2G)",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 238, 241),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
//                     width: 1.0, // Ketebalan garis tepi
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 15,
//                   ),
//                   child: TextFormField(
//                     controller: exhaustController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               // Lub Oil
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Lub Oil (Kg/Cm\u00B2G)",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 238, 241),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
//                     width: 1.0, // Ketebalan garis tepi
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 15,
//                   ),
//                   child: TextFormField(
//                     controller: lubOilController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               // Control Oil
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Control Oil (Kg/Cm\u00B2G)",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 238, 241),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
//                     width: 1.0, // Ketebalan garis tepi
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 15,
//                   ),
//                   child: TextFormField(
//                     controller: controlOilController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       addData();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16.0),
//                       ),
//                       minimumSize: const Size(100.0, 45.0), // Ubah ukuran sesuai keinginan
//                     ),
//                     child: const Text(
//                       'Save',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const CardPage(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       side: const BorderSide(color: Colors.blue),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16.0),
//                       ),
//                       minimumSize: const Size(100.0, 45.0), // Ubah ukuran sesuai keinginan
//                     ),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
