// import 'dart:convert';
// import 'package:logsheet_turbin/partials/color_pickers.dart';
// import 'package:logsheet_turbin/partials/font_pickers.dart';
// import 'package:logsheet_turbin/screens/home_screen.dart';
// import 'package:logsheet_turbin/screens/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:logsheet_turbin/utils/api_endpoints.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginController extends GetxController {
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//   void showError(title, error){
//     Get.back();
//     showDialog(
//       context: Get.context!,
//       builder: (context) {
//         return SimpleDialog(
//           title: Text(title, style: TextStyle(
//             color: (title == 'Warning') ? ColorPicker.orangeColor : ColorPicker.danger,
//             fontFamily: FontPicker.medium
//           ),),
//           contentPadding: const EdgeInsets.all(20),
//           children: [Text(error)],
//         );
//       });
//   }

//   Future<void> loginWithUsername() async {
//     var headers = {'Content-Type': 'application/json'};
//     var url = Uri.parse(
//           ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginUsername);
//     Map body = {
//       'email': usernameController.text.trim(),
//       'password': passwordController.text
//     };
//     http.Response response =
//         await http.post(url, body: jsonEncode(body), headers: headers);
//     if(usernameController.text == '' || passwordController.text == ''){
//       showError(
//         'Warning',
//         'Email or Password must be filled!'
//       );
//     }else{
//       try {
//         if (response.statusCode == 200) {
//           final json = jsonDecode(response.body);
//           if (json['code'] == 0) {
//             var token = json['token'];
//             var name = json['data']['name'];

//             final SharedPreferences prefs = await _prefs;
//             await prefs.setString('token', token);
//             await prefs.setString('name', name);

//             usernameController.clear();
//             passwordController.clear();
//             Get.off(const HomeScreen());
//           } else if (json['code'] == 1) {
//             throw jsonDecode(response.body)['errors'];
//           }
//         } else {
//           throw jsonDecode(response.body)["errors"] ?? "Unknown Error Occured";
//         }
//       } catch (error) {
//         showError('Error', error);
//       }
//     }
//   }

//   Future<void> logoutWithEmail() async {
//     // ignore: no_leading_underscores_for_local_identifiers
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var token = _prefs.getString('token');
//     var headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     };
              
//     try {
//       var url = Uri.parse(
//           ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.logoutEmail);
//       http.Response response =
//           await http.post(url, headers: headers);
//       // ignore: avoid_print
//       print(response.statusCode);
//       // print(response.body);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         _prefs.clear();
//         Get.off(const LoginScreen());
//         print(json);
//       } else {
//         throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
//       }
//     } catch (error) {
//       Get.back();
//       showDialog(
//           context: Get.context!,
//           builder: (context) {
//             return SimpleDialog(
//               title: const Text('Error'),
//               contentPadding: const EdgeInsets.all(20),
//               children: [Text(error.toString())],
//             );
//           });
//     }
//   }
// }