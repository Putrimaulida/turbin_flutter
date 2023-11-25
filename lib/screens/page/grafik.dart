import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logsheet_turbin/data/http_service.dart';
import 'package:logsheet_turbin/models/input3.dart'; // Pastikan path-nya benar
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailGrafik extends StatefulWidget {
  const DetailGrafik({Key? key}) : super(key: key);

  @override
  State<DetailGrafik> createState() => _DetailGrafikState();
}

class _DetailGrafikState extends State<DetailGrafik> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<Datum3>> fetchData() async {
    final prefs = await _prefs;
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.parse('${HttpService.baseUrl}/input3');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final input3Data = Input3.fromJson(jsonData);

      // Filter data berdasarkan rentang tanggal yang dipilih
      if (selectedDateRange != null) {
        input3Data.data = input3Data.data.where((datum) {
          return selectedDateRange!.start.isBefore(datum.createdAt) &&
              selectedDateRange!.end.isAfter(datum.createdAt);
        }).toList();
      }

      print(input3Data.data);
      return input3Data.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDateRange(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Datum3>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Daily Temperatur',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                    width: 25,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineChart(
                        mainData(snapshot.data!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Spasi antara grafik dan keterangan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCircleColor(Colors.blue, 'Water In'),
                      const SizedBox(width: 15),
                      _buildCircleColor(Colors.green, 'Water Out'),
                      const SizedBox(width: 15),
                      _buildCircleColor(Colors.red, 'Oil In'),
                      const SizedBox(width: 15),
                      _buildCircleColor(Colors.orange, 'Oil Out'),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }

  Widget _buildCircleColor(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 2),
        Text(label),
      ],
    );
  }

  LineChartData mainData(List<Datum3> data) {
    data.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    // Filter data untuk mengecualikan yang di bawah pukul 06:00
    DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 5, 0);
    data = data.where((datum) => datum.createdAt.isAfter(startDate)).toList();

    List<FlSpot> spotsWaterIn = [];
    List<FlSpot> spotsWaterOut = [];
    List<FlSpot> spotsOilIn = [];
    List<FlSpot> spotsOilOut = [];

    for (var datum in data) {
      double time = datum.createdAt.millisecondsSinceEpoch.toDouble();
      spotsWaterIn.add(FlSpot(time, datum.tempWaterIn));
      spotsWaterOut.add(FlSpot(time, datum.tempWaterOut));
      spotsOilIn.add(FlSpot(time, datum.tempOilIn));
      spotsOilOut.add(FlSpot(time, datum.tempOilOut));
    }

    // Tentukan tanggal mulai dan akhir yang ingin Anda tampilkan
    DateTime endDate = startDate.add(Duration(days: 1));

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          margin: 8,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          margin: 8,
          rotateAngle: 60,
          getTitles: (value) {
            final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
            return DateFormat('HH:00').format(date);
          },
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        lineChartBarData(spotsWaterIn, Colors.blue, "Water In"),
        lineChartBarData(spotsWaterOut, Colors.green, "Water Out"),
        lineChartBarData(spotsOilIn, Colors.red, "Oil In"),
        lineChartBarData(spotsOilOut, Colors.orange, "Oil Out"),
      ],
      minX: startDate.millisecondsSinceEpoch.toDouble(), // Atur batas waktu mulai
      maxX: endDate.millisecondsSinceEpoch.toDouble(),   // Atur batas waktu akhir
      minY: 0,
    );
  }

  LineChartBarData lineChartBarData(
      List<FlSpot> spots, Color color, String legendTitle) {
    return LineChartBarData(
      spots: spots,
      isCurved: false,
      colors: [color],
      barWidth: 3,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: true),
      aboveBarData: BarAreaData(show: false), // Tetapkan properti ini
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    // Tanggal hari ini
    DateTime now = DateTime.now();

    // Tanggal mulai, jam 06:00 pagi hari ini
    DateTime startDateTime = DateTime(now.year, now.month, now.day, 6, 0);

    // Tanggal berakhir, jam 05:00 pagi besok
    DateTime endDateTime = DateTime(now.year, now.month, now.day + 1, 5, 0);

    // Tentukan tanggal range
    DateTimeRange predefinedDateRange = DateTimeRange(start: startDateTime, end: endDateTime);

    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange ?? predefinedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });

      // Setelah tanggal dipilih, pindah ke halaman dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }
}
