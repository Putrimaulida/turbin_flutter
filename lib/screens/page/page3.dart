import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logsheet_turbin/data/http_service.dart';
import 'package:logsheet_turbin/models/input3.dart';
import 'package:logsheet_turbin/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailPage3 extends StatefulWidget {
const DetailPage3({Key? key}) : super(key: key);

  @override
  State<DetailPage3> createState() => _DetailPage3();
}

class _DetailPage3 extends State<DetailPage3> {
  bool isDataSavedInput3 = false;
  String loginErrorMessage = "";
  final Future<SharedPreferences> _prefs3 = SharedPreferences.getInstance();
  var input3List = <Input3>[];

   TextEditingController waterInController = TextEditingController();
   TextEditingController waterOutController = TextEditingController();
   TextEditingController oilInController = TextEditingController();
   TextEditingController oilOutController = TextEditingController();
   TextEditingController vacumController = TextEditingController();
   TextEditingController injectorController = TextEditingController();
   TextEditingController speedDropController = TextEditingController();
   TextEditingController loadLimitController = TextEditingController();
   TextEditingController floInController = TextEditingController();
   TextEditingController floOutController = TextEditingController();
   TextEditingController statusController = TextEditingController();

    bool _isInputEmpty() {
    return waterInController.text.isEmpty ||
        waterOutController.text.isEmpty ||
        oilInController.text.isEmpty ||
        oilOutController.text.isEmpty ||
        vacumController.text.isEmpty ||
        injectorController.text.isEmpty ||
        speedDropController.text.isEmpty ||
        loadLimitController.text.isEmpty ||
        floInController.text.isEmpty ||
        floOutController.text.isEmpty ||
        statusController.text.isEmpty;
  }

  bool _isInputValid() {
    try {
      double.parse(waterInController.text);
      double.parse(waterOutController.text);
      double.parse(oilInController.text);
      double.parse(oilOutController.text);
      double.parse(vacumController.text);
      double.parse(injectorController.text);
      double.parse(speedDropController.text);
      double.parse(loadLimitController.text);
      double.parse(floInController.text);
      double.parse(floOutController.text);
      double.parse(statusController.text);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPIInput3();
  }

  Future<void> fetchDataFromAPIInput3() async {
    try {
      var data = await getLatestDataSortedByCreatedAtInput3();
      if (data != null) {
        setState(() {
          waterInController.text = data.tempWaterIn.toString();
          waterOutController.text = data.tempWaterOut.toString();
          oilInController.text = data.tempOilIn.toString();
          oilOutController.text = data.tempOilOut.toString();
          vacumController.text = data.vacum.toString();
          injectorController.text = data.injector.toString();
          speedDropController.text = data.speedDrop.toString();
          loadLimitController.text = data.loadLimit.toString();
          floInController.text = data.floIn.toString();
          floOutController.text = data.floOut.toString();
          statusController.text = data.status.toString();
        });
      }
    } catch (error) {
      // Handle error here
      print(error.toString());
    }
  }

  Future<Datum3?> getLatestDataSortedByCreatedAtInput3() async {
    final prefs3 = await _prefs3;
    var token = prefs3.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      var url = Uri.parse('${HttpService.baseUrl}/input3/1');

      final response = await http.get(url, headers: headers);
      print(response.statusCode);
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var data = jsonData['data'];

        if (data.isNotEmpty) {
          var latestData = Datum3.fromJson(data[0]);
          return latestData;
        }
      }
    } catch (error) {
      print(error.toString());
    }

    return null;
  }

    Future<void> updateDataInput3() async {
    final pref3 = await SharedPreferences.getInstance();
    final token = pref3.getString('token');

    Map<String, dynamic> body = {
      'temp_water_in': double.tryParse(waterInController.text) ?? 0.0,
      'temp_water_out': double.tryParse(waterOutController.text) ?? 0.0,
      'temp_oil_in': double.tryParse(oilInController.text) ?? 0.0,
      'temp_oil_out': double.tryParse(oilOutController.text) ?? 0.0,
      'vacum': double.tryParse(vacumController.text) ?? 0.0,
      'injector': double.tryParse(injectorController.text) ?? 0.0,
      'speed_drop': double.tryParse(speedDropController.text) ?? 0.0,
      'load_limit': double.tryParse(speedDropController.text) ?? 0.0,
      'flo_in': double.tryParse(floInController.text) ?? 0.0,
      'flo_out': double.tryParse(floOutController.text) ?? 0.0,     
    };
    final test = jsonEncode(body);
    print(test);

    final response = await http.put(
      Uri.parse('${HttpService.baseUrl}/input3/1'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        isDataSavedInput3 = true;
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
        title: const Text('PAGE 3'),
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

              // Temp Water In
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    //"TWIN OIL COOOLER"
                    "Temp Water In (\u2103)",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: waterInController,
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

              // Temp Water Out
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Temp Water Out (\u2103)",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: waterOutController,
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

              // Temp Oil In
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Temp Oil In (\u2103)",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: oilInController,
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

              // Temp Oil Out
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Temp Oil Out (\u2103)",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: oilOutController,
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

              // Vacum
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Vacum",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: vacumController,
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

              // Injector
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Injector",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: injectorController,
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

              // Speed Drop
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    //"GOVERNOR"
                    "Speed Drop",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: speedDropController,
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

              // Load Limit
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Load Limit",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: loadLimitController,
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

              // In
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    //"FILTER LOB OIL"
                    "Flo In",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: floInController,
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

              // Out
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Flo Out",
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
                    color: const Color.fromARGB(
                        255, 195, 197, 199), // Warna garis tepi
                    width: 1.0, // Ketebalan garis tepi
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    controller: floOutController,
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
                            updateDataInput3();
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}