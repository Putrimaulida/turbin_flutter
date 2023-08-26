import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:logsheet_turbin/screens/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();

    // Delay waktu selama 2 detik sebelum berpindah ke halaman selanjutnya
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
              width: 25,
            ),
            Image(
              image: AssetImage("assets/images/logo.png"),
              width: 110,
            ),
            SizedBox(
              height: 100,
            ),
            SpinKitFadingCircle(
              color: Colors.blueAccent,
              size: 30.0,
            ),
            SizedBox(
              height: 150,
              width: 50,
            ),
            Image(
              image: AssetImage("assets/images/logo-sgn.png"),
              width: 230,
            ),
          ],
        ),
      ),
    );
  }
}
