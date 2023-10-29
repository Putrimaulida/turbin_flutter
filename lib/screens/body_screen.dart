import 'package:flutter/material.dart';
import 'package:logsheet_turbin/screens/page/page1.dart';
import 'package:logsheet_turbin/screens/page/page2.dart';
import 'package:logsheet_turbin/screens/page/page3.dart';
import 'package:logsheet_turbin/screens/profile/dashboard.dart';


class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DashboardScreen(),
          BundelCard1(isDataSaved: true,), 
          BundelCard2(),
          BundelCard3(),        
        ],
      ),
    );
  }
}

class BundelCard1 extends StatelessWidget {
  final bool isDataSaved;
  // ignore: use_key_in_widget_constructors
  const BundelCard1({Key? key, required this.isDataSaved});

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    final circleColor = isDataSaved == 0.0 ? Colors.green : const Color.fromARGB(255, 255, 213, 4);

    return Center(
      child: InkWell(
        onTap: () {
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
                    image: AssetImage('assets/images/coba.png'),
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
  const BundelCard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
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
                    image: AssetImage('assets/images/coba.png'),
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
                          color: Colors.yellow,
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

class BundelCard3 extends StatelessWidget {
  const BundelCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
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
                    image: AssetImage('assets/images/coba.png'),
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
                          color: Colors.yellow,
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