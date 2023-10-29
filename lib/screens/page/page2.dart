import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logsheet_turbin/data/http_service.dart';
import 'package:logsheet_turbin/models/input2.dart';
import 'package:logsheet_turbin/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailPage2 extends StatefulWidget {
  const DetailPage2({Key? key}) : super(key: key);

  @override
  State<DetailPage2> createState() => _DetailPage2();
}

class _DetailPage2 extends State<DetailPage2> {
  bool isDataSavedInput2 = false;
  String loginErrorMessage = "";
  final Future<SharedPreferences> _prefs2 = SharedPreferences.getInstance();
  var input2List = <Input2>[];

  final TextEditingController turbinSpeedController = TextEditingController();
  final TextEditingController rotorVibMonitorController = TextEditingController();
  final TextEditingController axialDisplacementMonitorController = TextEditingController();
  final TextEditingController mainSteamController = TextEditingController();
  final TextEditingController stageSteamController = TextEditingController();
  final TextEditingController exhaustController = TextEditingController();
  final TextEditingController lubOilController = TextEditingController();
  final TextEditingController controlOilController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  bool _isInputEmpty() {
    return turbinSpeedController.text.isEmpty ||
        rotorVibMonitorController.text.isEmpty ||
        axialDisplacementMonitorController.text.isEmpty ||
        mainSteamController.text.isEmpty ||
        stageSteamController.text.isEmpty ||
        exhaustController.text.isEmpty ||
        lubOilController.text.isEmpty ||
        controlOilController.text.isEmpty ||
        statusController.text.isEmpty;
  }

  bool _isInputValid() {
    try {
      double.parse(turbinSpeedController.text);
      double.parse(rotorVibMonitorController.text);
      double.parse(axialDisplacementMonitorController.text);
      double.parse(mainSteamController.text);
      double.parse(stageSteamController.text);
      double.parse(exhaustController.text);
      double.parse(lubOilController.text);
      double.parse(controlOilController.text);
      double.parse(statusController.text);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPIInput2();
  }

  Future<void> fetchDataFromAPIInput2() async {
    try {
      var data = await getLatestDataSortedByCreatedAtInput2();
      if (data != null) {
        setState(() {
          turbinSpeedController.text = data.turbinSpeed.toString();
          rotorVibMonitorController.text = data.rotorVibMonitor.toString();
          axialDisplacementMonitorController.text = data.axialDisplacementMonitor.toString();
          mainSteamController.text = data.mainSteam.toString();
          stageSteamController.text = data.stageSteam.toString();
          exhaustController.text = data.exhaust.toString();
          lubOilController.text = data.lubOil.toString();
          controlOilController.text = data.controlOil.toString();
          statusController.text = data.status.toString();
        });
      }
    } catch (error) {
      // Handle error here
      print(error.toString());
    }
  }

  Future<Datum2?> getLatestDataSortedByCreatedAtInput2() async {
    final prefs2 = await _prefs2;
    var token = prefs2.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      var url = Uri.parse('${HttpService.baseUrl}/input2/1');

      final response = await http.get(url, headers: headers);
      print(response.statusCode);
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var data = jsonData['data'];

        if (data.isNotEmpty) {
          var latestData = Datum2.fromJson(data[0]);
          return latestData;
        }
      }
    } catch (error) {
      print(error.toString());
    }

    return null;
  }

  Future<void> updateDataInput2() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');

    Map<String, dynamic> body = {
      'turbin_speed' : double.tryParse(turbinSpeedController.text) ?? 0.0,
            'rotor_vib_monitor' : double.tryParse(rotorVibMonitorController.text) ?? 0.0,
            'axial_displacement_monitor' : double.tryParse(axialDisplacementMonitorController.text) ?? 0.0,
            'main_steam' : double.tryParse(mainSteamController.text) ?? 0.0,
            'stage_steam' : double.tryParse(stageSteamController.text) ?? 0.0,
            'exhaust' : double.tryParse(exhaustController.text) ?? 0.0,
            'lub_oil' : double.tryParse(lubOilController.text) ?? 0.0,
            'control_oil' : double.tryParse(controlOilController.text) ?? 0.0,
    };
    final test = jsonEncode(body);
    print(test);

    final response = await http.put(
      Uri.parse('${HttpService.baseUrl}/input2/1'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        isDataSavedInput2 = true;
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
        title: const Text('PAGE 2'),
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
              // Turbin Speed
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Turbin Speed (RPM)",
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
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: turbinSpeedController,
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

              // Rotor Vibration Monitor
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Rotor Vibration Monitor (mm)",
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
                    color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: rotorVibMonitorController,
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

              // Axial Displace Ment Monitor
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Axial Displace Ment Monitor (mm)",
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
                    color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: axialDisplacementMonitorController,
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

              // Main Steam
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Main Steam (Kg/Cm\u00B2G)",
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
                    color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: mainSteamController,
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

              // 1ST Stage Steam
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "1ST Stage Steam (Kg/Cm\u00B2G)",
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
                    color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: stageSteamController,
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

              // Exhaust
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Exhaust (Kg/Cm\u00B2G)",
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
                    color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: exhaustController,
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

              // Lub Oil
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Lub Oil (Kg/Cm\u00B2G)",
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
                    color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: lubOilController,
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

              // Control Oil
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Control Oil (Kg/Cm\u00B2G)",
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
                    color: const Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: controlOilController,
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
                            updateDataInput2();
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
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
