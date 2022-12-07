import 'package:admin_aplication/controller/login_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences loginUser;
  late bool user;
  final formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  void checkLogin() async {
    loginUser = await SharedPreferences.getInstance();
    user = loginUser.getBool('login') ?? false;

    if (user == true) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  key: formKey,
                  child: Column(
                    children: [
                      // EMAIL
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Silahkan memasukkan Email';
                          }
                          if (!EmailValidator.validate(value)) {
                            return '* Masukkan email yang valid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // PASSWORD
                      Consumer<LoginProvider>(
                        builder: (context, value, _) {
                          return TextFormField(
                            controller: password,
                            obscureText: value.obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                onTap: () => provider.changeObscurePassword(),
                                child: value.obscurePassword
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.remove_red_eye),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Silahkan memasukkan Password';
                              } else if (value.length < 8) {
                                return '* Password harus minimal 8 karakter';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
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
                          onPressed: () {
                            final loginValid = formKey.currentState!.validate();

                            String userEmail = email.text;

                            if (loginValid) {
                              loginUser.setBool('login', true);
                              loginUser.setString('userEmail', userEmail);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login Berhasil!!'),
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      signUpButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("don't have account?"),
        TextButton(
          child: const Text(
            'SignUp',
            style: TextStyle(
              color: Color.fromARGB(194, 249, 7, 108),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/signup');
          },
        ),
      ],
    );
  }
}
