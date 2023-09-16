import 'package:flutter/material.dart';
import 'package:logsheet_turbin/screens/body_screen.dart';
import 'package:logsheet_turbin/screens/home_screen.dart';
import 'package:logsheet_turbin/screens/login_screen.dart';
import 'package:logsheet_turbin/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      backgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/body':(context) => const Body(),  
      },
    ); 
  }
}
