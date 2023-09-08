import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logsheet_turbin/models/loginError.dart';
import 'package:logsheet_turbin/models/token.dart';
import 'package:logsheet_turbin/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  bool isLoginInProgress = false;
  bool _isObscured = true;
  bool _passwordVisible = false;
  String loginErrorMessage = "";
  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,     
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                  width: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    "assets/images/logo.png", 
                    height: 150, 
                    width: 100, 
                    //fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 20,
                  ),
                  child: Text(
                    "Enjoy our features that help you manage your logsheet more effectively",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Schyler',
                    ),
                  ),
                ),
      
                // Email
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Username", 
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
                    color: Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                      width: 1.0, // Ketebalan garis tepi
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),                       
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
      
                // Password
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Password", 
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
                    color: Color.fromARGB(255, 241, 238, 241),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Color.fromARGB(255, 195, 197, 199), // Warna garis tepi
                      width: 1.0, // Ketebalan garis tepi
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      obscureText: !_passwordVisible,
                      controller: _passwordController,
                      
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 25,
                    bottom: 20,
                  ),
                ),

                Text(
                  loginErrorMessage,
                  style: const TextStyle(color: Colors.red),
                ),

                Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      onPressed: () async {
                        setState(
                          () {
                            isLoginInProgress = true;
                            loginErrorMessage = "";
                          },
                        );
                        if (_usernameController.text.isEmpty) {
                          setState(() {
                            loginErrorMessage = "Username cannot be empty!";
                            isLoginInProgress = false;
                          });
                          return;
                        } if (_passwordController.text.isEmpty) {
                          setState(() {
                            loginErrorMessage = "Password cannot be empty!";
                            isLoginInProgress = false;
                          });
                          return;
                        }

                        //request login
                        Map<String, String> headers = {"Accept": "application/json"};
                        final response = await http.post(
                          Uri.parse('http://192.168.60.107:8000/api/login'),
                          headers: headers,
                          body: {
                            'username': _usernameController.text,
                            'password': _passwordController.text,
                          },
                        );
                        if (response.statusCode == 200) {
                          final jsonResponse = json.decode(response.body);
                          final token = Token.fromJson(jsonResponse);
                          final prefs = await SharedPreferences.getInstance();
                          print("Token From Api ${token.token}");
                          if (token.token != null) {
                            await prefs.setString(
                              'token',
                              jsonDecode(response.body)['token'],
                            );
                            setState(
                              () {
                                isLoginInProgress = false;
                                isLoggedIn = true;
                              },
                            );

                            if (!mounted) {
                              return;
                            }
                            if (isLoggedIn) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => const HomeScreen(),
                                ),
                              );
                            }
                          }
                        } 
                        
                        else if (response.statusCode == 401){
                          setState(() {
                            loginErrorMessage = "Invalid username or password!";
                            isLoginInProgress = false;                          
                          });
                        } else {
                          setState(() {
                            loginErrorMessage = "Username or Password cannot be empty!";
                            isLoginInProgress = false;
                          });
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Login", 
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
              visible: isLoginInProgress,
              child: const CircularProgressIndicator(),
            ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}