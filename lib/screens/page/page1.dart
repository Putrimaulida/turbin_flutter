import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logsheet_turbin/data/http_service.dart';
import 'package:logsheet_turbin/models/input1.dart';
import 'package:logsheet_turbin/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailPage1 extends StatefulWidget {
  const DetailPage1({Key? key}) : super(key: key);

  @override
  State<DetailPage1> createState() => _DetailPage1State();
}

class _DetailPage1State extends State<DetailPage1> {
  bool isDataSaved = false;
  String loginErrorMessage = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var input1List = <Input1>[];

  TextEditingController inletSteamController = TextEditingController();
  TextEditingController exmSteamController = TextEditingController();
  TextEditingController turbinThrustBearingController = TextEditingController();
  TextEditingController tbGovSideController = TextEditingController();
  TextEditingController tbCoupSideController = TextEditingController();
  TextEditingController pbTbnSideController = TextEditingController();
  TextEditingController pbGenSideController = TextEditingController();
  TextEditingController wbTbnSideController = TextEditingController();
  TextEditingController wbGenSideController = TextEditingController();
  TextEditingController ocLubOilSoutletController = TextEditingController();
  TextEditingController statusController = TextEditingController();

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
        ocLubOilSoutletController.text.isEmpty ||
        statusController.text.isEmpty;
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
      double.parse(statusController.text);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    try {
      var data = await getLatestDataSortedByCreatedAt();
      if (data != null) {
        setState(() {
          inletSteamController.text = data.inletSteam.toString();
          exmSteamController.text = data.exmSteam.toString();
          turbinThrustBearingController.text = data.turbinThrustBearing.toString();
          tbGovSideController.text = data.tbGovSide.toString();
          tbCoupSideController.text = data.tbCoupSide.toString();
          pbTbnSideController.text = data.pbTbnSide.toString();
          pbGenSideController.text = data.pbGenSide.toString();
          wbTbnSideController.text = data.wbTbnSide.toString();
          wbGenSideController.text = data.wbGenSide.toString();
          ocLubOilSoutletController.text = data.ocLubOilOutlet.toString();
          statusController.text = data.status.toString();
        });
      }
    } catch (error) {
      // Handle error here
      print(error.toString());
    }
  }

  Future<Datum?> getLatestDataSortedByCreatedAt() async {
    final prefs = await _prefs;
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      var url = Uri.parse('${HttpService.baseUrl}/input1/1');

      final response = await http.get(url, headers: headers);
      print(response.statusCode);
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var data = jsonData['data'];

        if (data.isNotEmpty) {
          var latestData = Datum.fromJson(data[0]);
          return latestData;
        }
      }
    } catch (error) {
      print(error.toString());
    }

    return null;
  }

  Future<void> updateData() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');

    Map<String, dynamic> body = {
      'inlet_steam': double.tryParse(inletSteamController.text) ?? 0.0,
      'exm_steam': double.tryParse(exmSteamController.text) ?? 0.0,
      'turbin_thrust_bearing': double.tryParse(turbinThrustBearingController.text) ?? 0.0,
      'tb_gov_side': double.tryParse(tbGovSideController.text) ?? 0.0,
      'tb_coup_side': double.tryParse(tbCoupSideController.text) ?? 0.0,
      'pb_tbn_side': double.tryParse(pbTbnSideController.text) ?? 0.0,
      'pb_gen_side': double.tryParse(pbGenSideController.text) ?? 0.0,
      'wb_tbn_side': double.tryParse(wbTbnSideController.text) ?? 0.0,
      'wb_gen_side': double.tryParse(wbGenSideController.text) ?? 0.0,
      'oc_lub_oil_outlet': double.tryParse(ocLubOilSoutletController.text) ?? 0.0,
    };
    final test = jsonEncode(body);
    print(test);

    final response = await http.put(
      Uri.parse('${HttpService.baseUrl}/input1/1'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

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
      print('testResponse');
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
      body: Center(
        child: SafeArea(
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
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(255, 241, 238, 241),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: inletSteamController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: exmSteamController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: turbinThrustBearingController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: tbGovSideController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: tbCoupSideController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: pbTbnSideController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: pbGenSideController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: wbTbnSideController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: wbGenSideController,
                      keyboardType: TextInputType.number,
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: ocLubOilSoutletController,
                      keyboardType: TextInputType.number,
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

                // status
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Status",
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
                    color: const Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 195, 197, 199),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: statusController,
                      keyboardType: TextInputType.number,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isInputEmpty()) {
                            setState(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  loginErrorMessage =
                                      "Please fill in all fields.",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: const Color.fromARGB(255, 75,
                                    93, 101), // Warna latar belakang Snackbar
                              ),
                            );
                          } else if (!_isInputValid()) {
                            setState(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  loginErrorMessage = "Invalid input format.",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: const Color.fromARGB(255, 75,
                                    93, 101), // Warna latar belakang Snackbar
                              ),
                            );
                          } else {
                            updateData();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          minimumSize: const Size(
                              100.0, 45.0), // Ubah ukuran sesuai keinginan
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                if (isDataSaved)
                  const Text(
                    "Data saved successfully.",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}