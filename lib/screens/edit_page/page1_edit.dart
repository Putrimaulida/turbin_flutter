import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logsheet_turbin/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditDetailPage1 extends StatefulWidget {
  final int id;
  final double input1;
  const EditDetailPage1({Key? key, required this.id, required this.input1}): super(key: key);

  @override
  State<EditDetailPage1> createState() => _EditDetailPage1State();
}

class _EditDetailPage1State extends State<EditDetailPage1> {
  bool isDataSaved = false;
  String loginErrorMessage = "";
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

  @override
  void initState() {
    setState(() {
      inletSteamController.text = widget.input1 as String; 
        exmSteamController.text = widget.input1 as String;
        turbinThrustBearingController.text = widget.input1 as String; 
        tbGovSideController.text = widget.input1 as String; 
        tbCoupSideController.text = widget.input1 as String; 
        pbTbnSideController.text = widget.input1 as String; 
        pbGenSideController.text = widget.input1 as String; 
        wbTbnSideController.text = widget.input1 as String; 
        wbGenSideController.text = widget.input1 as String; 
        ocLubOilSoutletController.text = widget.input1 as String;
    });
    super.initState();
  }

  @override
  void dispose() {
    inletSteamController.dispose();
    exmSteamController.dispose();
      turbinThrustBearingController.dispose();
      tbGovSideController.dispose();
      tbCoupSideController.dispose();
      pbTbnSideController.dispose(); 
      pbGenSideController.dispose(); 
      wbTbnSideController.dispose(); 
      wbGenSideController.dispose(); 
      ocLubOilSoutletController.dispose();

    super.dispose();
  }

    void editData(id) async {
    //request edit
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
    final response = await http.put(
      Uri.parse('http://192.168.1.6:8000/api/input1/1/$id'),
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
    final response = await http.post(
      Uri.parse('http://192.168.21.107:8000/api/input1'),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
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
                          // Set pesan error jika data kosong
                          loginErrorMessage = "Data cannot be empty!";
                        });
                      } else if (!_isInputValid()) {
                        setState(() {
                        loginErrorMessage = "Enter data with numbers!";
                        });
                      } else if (isDataSaved) {
                        editData(widget.id);
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
