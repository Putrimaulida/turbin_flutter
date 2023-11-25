import 'package:flutter/material.dart';
import 'package:logsheet_turbin/screens/login_screen.dart';
import 'package:logsheet_turbin/screens/page/grafik.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../data/http_service.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 196, 192, 192),
                          width: 1.0))),
              child: Text(
                'PT Sinergi Gula Nusantara',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailGrafik(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text('Logsheet Turbin'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const CardPage(),
              //   ),
              // );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: InkWell(
              onTap: () async {
                // Permintaan logout
                final pref = await SharedPreferences.getInstance();
                final token = pref.getString('token');

                final logoutRequest = await http.post(
                  Uri.parse('${HttpService.baseUrl}/logout'),
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer $token',
                  },
                );
                if (logoutRequest.statusCode == 200) {
                  print("Logout berhasil");
                  // Logout berhasil, hapus token
                  pref.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen(),
                    )
                  );
                }
              },
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
              ),
            ),
          )
        ],
      ),
    );
  }
}