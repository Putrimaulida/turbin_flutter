import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logsheet_turbin/data/http_service.dart';
import 'package:logsheet_turbin/models/input1.dart';
import 'package:logsheet_turbin/models/input2.dart';
import 'package:logsheet_turbin/models/input3.dart';
import 'package:logsheet_turbin/screens/page/page1.dart';
import 'package:logsheet_turbin/screens/page/page2.dart';
import 'package:logsheet_turbin/screens/page/page3.dart';
import 'package:logsheet_turbin/screens/profile/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Future<SharedPreferences> _prefs2 = SharedPreferences.getInstance();
  final Future<SharedPreferences> _prefs3 = SharedPreferences.getInstance();
  late bool statusData = false;
  late bool statusDataIsian = false;
  late bool statusData2 = false;
  late bool statusDataIsian2 = false;
  late bool statusData3 = false;
  late bool statusDataIsian3 = false;
  
  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
    fetchDataFromAPIInput2();
    fetchDataFromAPIInput3();
  }

  Future<void> fetchDataFromAPI() async {
    try {
      var data = await getLatestDataSortedByCreatedAt();
      if (data != null) {
        setState(() {
          statusData = true;
          bool allZero = data.inletSteam == 0 &&
              data.exmSteam == 0 &&
              data.turbinThrustBearing == 0 &&
              data.tbGovSide == 0 &&
              data.tbCoupSide == 0 &&
              data.pbTbnSide == 0 &&
              data.pbGenSide == 0 &&
              data.wbTbnSide == 0 &&
              data.wbTbnSide == 0 &&
              data.ocLubOilOutlet == 0;

          if (allZero) {
            statusDataIsian = true;
          } else {
            statusDataIsian = false;
          }
        });
      }
    } catch (error) {
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
  

  Future<void> fetchDataFromAPIInput2() async {
    try {
      var data = await getLatestDataSortedByCreatedAtInput2();
      if (data != null) {
        setState(() {
          statusData2 = true;
          bool allZero = data.turbinSpeed == 0 &&
              data.rotorVibMonitor == 0 &&
              data.axialDisplacementMonitor == 0 &&
              data.mainSteam == 0 &&
              data.stageSteam == 0 &&
              data.exhaust == 0 &&
              data.lubOil == 0 &&
              data.controlOil == 0;

          if (allZero) {
            statusDataIsian2 = true;
          } else {
            statusDataIsian2 = false;
          }
        });
      }
    } catch (error) {
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

  Future<void> fetchDataFromAPIInput3() async {
    try {
      var data = await getLatestDataSortedByCreatedAtInput3();
      if (data != null) {
        setState(() {
          statusData3 = true;
          bool allZero = data.tempWaterIn == 0 &&
              data.tempWaterOut == 0 &&
              data.tempOilIn == 0 &&
              data.tempOilOut == 0 &&
              data.vacum == 0 &&
              data.injector == 0 &&
              data.speedDrop == 0 &&
              data.loadLimit == 0 &&
              data.floIn == 0 &&
              data.floOut == 0;

          if (allZero) {
            statusDataIsian3 = true;
          } else {
            statusDataIsian3 = false;
          }
        });
      }
    } catch (error) {
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


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const DashboardScreen(),
          BundelCard1(
              isDataSaved: true,
              statusData: statusData,
              statusDataIsian: statusDataIsian),
          BundelCard2(
              isDataSavedInput2: true,
              statusData2: statusData2,
              statusDataIsian2: statusDataIsian2),
          BundelCard3(
              isDataSavedInput3: true,
              statusData3: statusData3,
              statusDataIsian3: statusDataIsian3),
        ],
      ),
    );
  }
}

class BundelCard1 extends StatelessWidget {
  final bool isDataSaved;
  final bool statusData;
  final bool statusDataIsian;
  // ignore: use_key_in_widget_constructors
  const BundelCard1(
      {Key? key,
      required this.isDataSaved,
      required this.statusData,
      required this.statusDataIsian});

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    final circleColor = statusDataIsian == true
        ? const Color.fromARGB(255, 255, 213, 4)
        : statusData == true
            ? Colors.green
            : const Color.fromARGB(255, 255, 213, 4);
    return Center(
      child: InkWell(
        onTap: () {
          print(statusDataIsian);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailPage1()),
          );
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 180,
            minWidth: 400,
          ),
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: circleColor,
                          border: Border.all(
                            color: Colors.white,  // Warna garis tepi
                            width: 1.3,           // Lebar garis tepi
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PAGE 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                          ),
                          Text(
                            'Additional Text Below PAGE 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      bottom: 16,
                      right: 16,
                      child: Image(
                        image: AssetImage('assets/images/text-generator.png'),
                        height: 110,
                        width: 110,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BundelCard2 extends StatelessWidget {
final bool isDataSavedInput2;
  final bool statusData2;
  final bool statusDataIsian2;
  // ignore: use_key_in_widget_constructors
  const BundelCard2(
      {Key? key,
      required this.isDataSavedInput2,
      required this.statusData2,
      required this.statusDataIsian2});

  @override
  Widget build(BuildContext context) {
    final circleColor2 = statusDataIsian2 == true
        ? const Color.fromARGB(255, 255, 213, 4)
        : statusData2 == true
            ? Colors.green
            : const Color.fromARGB(255, 255, 213, 4);
    return Center(
      child: InkWell(
        onTap: () {
          print(statusDataIsian2);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailPage2()),
          );
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 180,
            minWidth: 400,
          ),
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: circleColor2,
                          border: Border.all(
                            color: Colors.white,  // Warna garis tepi
                            width: 1.3,           // Lebar garis tepi
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PAGE 2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                          ),
                          Text(
                            'Additional Text Below PAGE 2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      bottom: 16,
                      right: 16,
                      child: Image(
                        image: AssetImage('assets/images/generator2.png'),
                        height: 110,
                        width: 110,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BundelCard3 extends StatelessWidget {
  final bool isDataSavedInput3;
  final bool statusData3;
  final bool statusDataIsian3;
  // ignore: use_key_in_widget_constructors
  const BundelCard3(
      {Key? key,
      required this.isDataSavedInput3,
      required this.statusData3,
      required this.statusDataIsian3});

  @override
  Widget build(BuildContext context) {
    final circleColor3 = statusDataIsian3 == true
        ? const Color.fromARGB(255, 255, 213, 4)
        : statusData3 == true
            ? Colors.green
            : const Color.fromARGB(255, 255, 213, 4);
    return Center(
      child: InkWell(
        onTap: () {
          print(statusDataIsian3);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailPage3()),
          );
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 180,
            minWidth: 400,
          ),
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: circleColor3,
                          border: Border.all(
                            color: Colors.white,  // Warna garis tepi
                            width: 1.3,           // Lebar garis tepi
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PAGE 3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                          ),
                          Text(
                            'Additional Text Below PAGE 3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      bottom: 16,
                      right: 16,
                      child: Image(
                        image: AssetImage('assets/images/electric-generator.png'),
                        height: 110,
                        width: 110,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}