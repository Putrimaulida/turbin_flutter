// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:logsheet_turbin/screens/page/card_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class DetailPage3 extends StatefulWidget {
//   const DetailPage3({super.key});

//   @override
//   State<DetailPage3> createState() => _DetailPage3();
// }

// class _DetailPage3 extends State<DetailPage3> {
//   bool isDataSaved = false;
//   final TextEditingController waterInController = TextEditingController();
//   final TextEditingController waterOutController = TextEditingController();
//   final TextEditingController oilInController = TextEditingController();
//   final TextEditingController oilOutController = TextEditingController();
//   final TextEditingController vacumController = TextEditingController();
//   final TextEditingController injectorController = TextEditingController();
//   final TextEditingController speedDropController = TextEditingController();
//   final TextEditingController loadLimitController = TextEditingController();
//   final TextEditingController floInController = TextEditingController();
//   final TextEditingController floOutController = TextEditingController();

//   void addData() async {
//     //request add
//     final pref = await SharedPreferences.getInstance();
//     final token = pref.getString('token');
//     Map body = {
//       'temp_water_in': waterInController.text,
//       'temp_water_out':waterOutController.text,
//       'temp_oil_in': oilInController.text,
//       'temp_oil_out': oilOutController.text,
//       'vacum': vacumController.text,
//       'injector': injectorController.text,
//       'speed_drop': speedDropController.text,
//       'load_limit': speedDropController.text,
//       'flo_in': floInController.text,
//       'flo_out': floOutController.text,
//     };
//     final response = await http.post(
//       Uri.parse('http://192.168.21.107:8000/api/input3'),
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
//         title: const Text('PAGE 3'),
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

//               // Temp Water In
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     //"TWIN OIL COOOLER"
//                     "Temp Water In (\u2103)",
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
//                     controller: waterInController,
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

//               // Temp Water Out
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Temp Water Out (\u2103)",
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
//                     controller: waterOutController,
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

//               // Temp Oil In
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Temp Oil In (\u2103)",
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
//                     controller: oilInController,
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

//               // Temp Oil Out
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Temp Oil Out (\u2103)",
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
//                     controller: oilOutController,
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

//               // Vacum
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Vacum",
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
//                     controller: vacumController,
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

//               // Injector
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Injector",
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
//                     controller: injectorController,
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

//               // Speed Drop
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     //"GOVERNOR"
//                     "Speed Drop",
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
//                     controller: speedDropController,
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

//               // Load Limit
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Load Limit",
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
//                     controller: loadLimitController,
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

//               // In
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     //"FILTER LOB OIL"
//                     "Flo In",
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
//                     controller: floInController,
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

//               // Out
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Flo Out",
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
//                     controller: floOutController,
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
