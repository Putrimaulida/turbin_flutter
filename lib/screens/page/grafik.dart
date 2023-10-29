import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Contoh halaman tujuan
class DetailGrafik extends StatelessWidget {
  const DetailGrafik({super.key});

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
      ),
      body: const SizedBox(
        height: 300,
        child: LineChartSample()),
    );
  }
}

class LineChartSample extends StatelessWidget {
  const LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Chart Sample'),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            // Konfigurasi data untuk Line Chart
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              // Mengatur teks pada sumbu x dan y
              bottomTitles: SideTitles(
                showTitles: true,
                //getTextStyles: (value) => const TextStyle(color: Colors.black),
                getTitles: (value) {
                  // Anda dapat mengganti teks sesuai dengan nilai sumbu x yang Anda inginkan.
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'May';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    // tambahkan nilai lain sesuai kebutuhan
                    default:
                      return '';
                  }
                },
                margin: 8,
              ),
              // leftTitles: SideTitles(
              //   showTitles: true,
              //   //getTextStyles: (value) => const TextStyle(color: Colors.black),
              //   getTitles: (value) {
              //     // Anda dapat mengganti teks sesuai dengan nilai sumbu y yang Anda inginkan.
              //     switch (value.toInt()) {
              //       case 0:
              //         return '0';
              //       case 2:
              //         return '2';
              //       case 4:
              //         return '4';
              //       case 6:
              //         return '6';
              //       // tambahkan nilai lain sesuai kebutuhan
              //       default:
              //         return '';
              //     }
              //   },
              //   margin: 12,
              // ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            // minX: 0,
            // maxX: 6,
            // minY: 0,
            // maxY: 6,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 3),
                  const FlSpot(1, 1),
                  const FlSpot(2, 4),
                  const FlSpot(3, 2),
                  const FlSpot(4, 5),
                  const FlSpot(5, 2),
                  const FlSpot(6, 4),
                ],
                isCurved: true,
                colors: [Colors.blue], // Ganti dengan warna sesuai kebutuhan
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
