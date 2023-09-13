import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logsheet_turbin/models/input1.dart';
import 'package:logsheet_turbin/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailPage1 extends StatefulWidget {
  const DetailPage1({super.key});

  @override
  State<DetailPage1> createState() => _DetailPage1State();
}

class _DetailPage1State extends State<DetailPage1> {
  bool isDataSaved = false;
  String loginErrorMessage = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var input1List = <Input1>[];

  final TextEditingController inletSteamController = TextEditingController();
  final TextEditingController exmSteamController = TextEditingController();
  final TextEditingController turbinThrustBearingController = TextEditingController();
  final TextEditingController tbGovSideController = TextEditingController();
  final TextEditingController tbCoupSideController = TextEditingController();
  final TextEditingController pbTbnSideController = TextEditingController();
  final TextEditingController pbGenSideController = TextEditingController();
  final TextEditingController wbTbnSideController = TextEditingController();
  final TextEditingController wbGenSideController = TextEditingController();
  final TextEditingController ocLubOilSoutletController = TextEditingController();

  bool _isInputEmpty() {
    return inletSteamController.text.isEmpty ||
        exmSteamController.text.isEmpty ||
        turbinThrustBearingController.text.isEmpty ||
        tbGovSideController.text.isEmpty ||
        tbCoupSideController.text.isEmpty ||
        pbTbnSideController.text.isEmpty ||
        pbGenSideController.text.isEmpty ||
        wbTbnSideController.text.isEmpty ||
        wbGenSideController.text.isEmpty ||
        ocLubOilSoutletController.text.isEmpty;
  }

  bool _isInputValid() {
    try {
      double.parse(inletSteamController.text);
      double.parse(exmSteamController.text);
      double.parse(turbinThrustBearingController.text);
      double.parse(tbGovSideController.text);
      double.parse(tbCoupSideController.text);
      double.parse(pbTbnSideController.text);
      double.parse(pbGenSideController.text);
      double.parse(wbTbnSideController.text);
      double.parse(wbGenSideController.text);
      double.parse(ocLubOilSoutletController.text);
    
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Input1?> getList() async {
    final prefs = await _prefs;
    var token = prefs.getString('token');
    print(token);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var url = Uri.parse("http://192.168.1.2:8000/api/categories");

      final response = await http.get(url, headers: headers);

      print(response.statusCode);
      print(input1List.length);
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return input1FromJson(jsonString);
      }
    } catch (error) {
      print('Testing');
    }
    return null;
  }

  void addData() async {
    //request add
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    Map body = {
      'inlet_steam': inletSteamController.text,
      'exm_steam': exmSteamController.text,
      'turbin_thrust_bearing': turbinThrustBearingController.text,
      'tb_gov_side': tbGovSideController.text,
      'tb_coup_side': tbCoupSideController.text,
      'pb_tbn_side': pbTbnSideController.text,
      'pb_gen_side': pbGenSideController.text,
      'wb_tbn_side': wbTbnSideController.text,
      'wb_gen_side': wbGenSideController.text,
      'oc_lub_oil_outlet': ocLubOilSoutletController.text,
    };
    // memakai put
    final response = await http.post(
      Uri.parse('http://192.168.1.2:8000/api/input1'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isDataSaved = true;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        ),
      );
    } else {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAGE 1'),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
                width: 25,
              ),

               Text(
                DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 25,
                width: 25,
              ),
              // Inleat Steam
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Inleat Steam (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 241, 238, 241),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: inletSteamController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$'))
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Exm. Steam
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Exm. Steam (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                     color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: exmSteamController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Turbin Thrust Bearing
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Turbin Thrust Bearing (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                     color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: turbinThrustBearingController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Turbin Bearing (Gov Side)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Turbin Bearing / Gov Side (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: tbGovSideController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Turbin Bearing (Coup. Side)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Turbin Bearing / Coup. Side (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: tbCoupSideController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Pinion Bearing (Tbn. Side)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Pinion Bearing / Tbn. Side (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: pbTbnSideController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Pinion Bearing (Gen Side)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Pinion Bearing / Gen Side (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: pbGenSideController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Wheel Bearing (Thn. Side)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Wheel Bearing / Thn. Side (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: wbTbnSideController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Wheel Bearing (Gen Side)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Wheel Bearing / Gen Side (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: wbGenSideController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Oil Cooler Lub. Oil Outlet
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Oil Cooler Lub. Oil Outlet (\u2103)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 238, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: ocLubOilSoutletController,
                    inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\d]+(\.\d{0,2})?$')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Text(
                loginErrorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_isInputEmpty()) {
                        setState(() {
                          loginErrorMessage = "Data cannot be empty!";
                        });
                      } else if (!_isInputValid()) {
                        setState(() {
                        loginErrorMessage = "Enter data with numbers!";
                        });
                      } else {
                        addData();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      minimumSize: Size(100.0, 45.0), // Ubah ukuran sesuai keinginan
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      minimumSize: Size(100.0, 45.0), // Ubah ukuran sesuai keinginan
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
