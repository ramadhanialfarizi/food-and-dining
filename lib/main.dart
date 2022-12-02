import 'package:admin_aplication/controller/food_provider.dart';
import 'package:admin_aplication/pages/home_page.dart';
import 'package:admin_aplication/pages/login_page.dart';
import 'package:admin_aplication/pages/widget/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FoodProvider(),
        ),
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
        }
        return null;
      },
    );
  }
}
