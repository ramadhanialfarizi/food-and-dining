import 'package:admin_aplication/controller/food_provider.dart';
import 'package:admin_aplication/controller/login_provider.dart';
import 'package:admin_aplication/controller/register_provider.dart';
import 'package:admin_aplication/pages/edit_profile_page.dart';
import 'package:admin_aplication/pages/home_page.dart';
import 'package:admin_aplication/pages/login_page.dart';
import 'package:admin_aplication/pages/profile_page.dart';
import 'package:admin_aplication/pages/signup_page.dart';
import 'package:admin_aplication/pages/widget/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FoodProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => const SplashScreen(), settings: settings);
          case '/login':
            return CupertinoPageRoute(
                builder: (_) => const LoginPage(), settings: settings);
          case '/home':
            return CupertinoPageRoute(
                builder: (_) => const HomePage(), settings: settings);
          case '/profile':
            return CupertinoPageRoute(
                builder: (_) => const ProfilePage(), settings: settings);
          case '/signup':
            return CupertinoPageRoute(
                builder: (_) => const SignUpPage(), settings: settings);
          case '/edit_profile':
            return CupertinoPageRoute(
                builder: (_) => const EditProfilePages(), settings: settings);
        }
        return null;
      },
    );
  }
}
