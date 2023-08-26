import 'package:flutter/material.dart';
import 'package:logsheet_turbin/screens/login_screen.dart';
import 'package:logsheet_turbin/screens/page/card_page.dart';
import 'package:logsheet_turbin/screens/page/grafik.dart';

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
                border: Border(bottom: BorderSide(color: Color.fromARGB(255, 196, 192, 192), width: 1.0))
              ),
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
                  builder: (context) => DetailGrafik(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text('Logsheet Turbin'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardPage(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
          // Add more menu items as needed
        ],
      ),
    );
  }
}
