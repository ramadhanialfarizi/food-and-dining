import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late SharedPreferences loginUser;
  final userEmail = FirebaseAuth.instance;

  void initialLogin() async {
    loginUser = await SharedPreferences.getInstance();
    // setState(() {
    //   userEmail = loginUser.getString('userEmail').toString();
    // });
  }

  @override
  void initState() {
    super.initState();
    initialLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Welcome...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // USER EMAIL
            accountEmail: Text(
              userEmail.currentUser!.email as String,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/food_images.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Your Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: ElevatedButton.icon(
              icon: Icon(Icons.account_circle, color: Colors.white),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(194, 249, 7, 108)),
              ),
              onPressed: () async {
                loginUser.setBool('login', false);
                loginUser.remove('userEmail');
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
