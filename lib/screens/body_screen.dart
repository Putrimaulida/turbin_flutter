import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logsheet_turbin/models/input1.dart';
import 'package:logsheet_turbin/screens/page/page1.dart';
import 'package:logsheet_turbin/screens/page/page2.dart';
import 'package:logsheet_turbin/screens/page/page3.dart';
import 'package:logsheet_turbin/screens/profile/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DashboardScreen(),
          BundelCard1(),
          BundelCard2(),
          BundelCard3(),
        ],
      ),
    );
  }
}

class BundelCard1 extends StatelessWidget {
  const BundelCard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // bisa dikasi if data= null detail page 1 save
      // jika data data!=null masuk ke detail page 1 edit
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
              // Use ClipRRect to make the background circular
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
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
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Image(
                        image: AssetImage('assets/images/text-generator.png'),
                        height: 110,
                        width: 110,
                      ),
                    ),
                    // Positioned(
                    //   top: 30.0, // Sesuaikan dengan posisi yang sesuai
                    //   right: 30.0, // Sesuaikan dengan posisi yang sesuai
                    //   child: Padding(
                    //     padding: EdgeInsets.all(8.0), // Sesuaikan padding sesuai kebutuhan
                    //     child: Image(
                    //       image: AssetImage('assets/images/circlek.png'),
                    //       height: 29,
                    //       width: 29,
                    //     ),
                    //   ),
                    // ),
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
              // Use ClipRRect to make the background circular
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg3.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
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
                    Positioned(
                      bottom: 16.0, // Atur posisi dari bawah
                      right: 16.0, // Atur posisi dari kanan
                      child: Image(
                        image: AssetImage('assets/images/energy-consumption.png'),
                        height: 115,
                        width: 115,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(16.0),
                    //   child: Image(
                    //     image: AssetImage('assets/images/energy-consumption.png'),
                    //     height: 115,
                    //     width: 115,
                    //   ),
                    // ),
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
              // Use ClipRRect to make the background circular
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
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
                    Padding(
                      padding: EdgeInsets.all(16.0),
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


