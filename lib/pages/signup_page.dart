import 'package:admin_aplication/controller/register_provider.dart';
import 'package:admin_aplication/model/user_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/login_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  var firstNameKey = GlobalKey<FormState>();
  var lastNameKey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormFieldState>();
  var passwordKey = GlobalKey<FormFieldState>();
  var confirmKey = GlobalKey<FormFieldState>();

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider =
        Provider.of<RegisterProvider>(context, listen: false);
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
                'Buat Akun Kamu terlebih dahulu :)',
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
                      /// INPUT FIRSTNAME
                      TextFormField(
                        key: firstNameKey,
                        controller: firstName,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Silahkan masukan Nama pertama anda';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      /// INPUT LASTNAME
                      TextFormField(
                        key: lastNameKey,
                        controller: lastName,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Silahkan masukan Nama terakhir anda';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        key: emailKey,
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Silahkan masukkan Email anda';
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
                      Consumer<RegisterProvider>(
                        builder: (context, value, _) {
                          return TextFormField(
                            key: passwordKey,
                            controller: password,
                            obscureText: value.obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                onTap: () =>
                                    signUpProvider.changeObscurePassword(),
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
                        height: 15,
                      ),
                      Consumer<RegisterProvider>(
                        builder: (context, value, _) {
                          return TextFormField(
                            key: confirmKey,
                            controller: confirmPassword,
                            obscureText: value.obscureConfirmPassword,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              suffixIcon: InkWell(
                                onTap: () => signUpProvider
                                    .changeObscureConfirmPassword(),
                                child: value.obscureConfirmPassword
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.remove_red_eye),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Silahkan konfirmasi Password';
                              }
                              // if (confirmPassword != password.text) {
                              //   return '* Confirm password tidak sesuai';
                              // }
                              return null;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 55,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                            icon: const Icon(Icons.account_circle,
                                color: Colors.white),
                            label: Text(
                              'Sign Up',
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
                              final loginValid =
                                  formKey.currentState!.validate();

                              String _firstName = firstName.text;
                              String _lastName = lastName.text;
                              String _email = email.text;
                              String _password = password.text;
                              if (loginValid) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Signup Berhasil!!'),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                );

                                final newUser = UserModel(
                                  firstName: _firstName,
                                  lastName: _lastName,
                                  email: _email,
                                  password: _password,
                                );

                                signUpProvider.addUserAcc(newUser);

                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              }

                              // String userEmail = email.text;

                              // if (loginValid) {
                              //   loginUser.setBool('login', true);
                              //   loginUser.setString('userEmail', userEmail);
                              // Navigator.of(context)
                              //     .pushReplacementNamed('/login');
                              //}
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
