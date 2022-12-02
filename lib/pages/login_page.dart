import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/food_icon.png',
                  scale: 1.5,
                ),
                SizedBox(
                  height: 19,
                ),
                const Text(
                  'Hi, Selamat Datang kembali :)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(),
                        SizedBox(
                          height: 45,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            },
                            icon: const Icon(Icons.account_circle,
                                color: Colors.white),
                            label: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(194, 249, 7, 108)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
