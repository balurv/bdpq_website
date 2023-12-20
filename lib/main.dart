import 'package:flutter/material.dart';
import 'package:form_data/pages/CreateFarmField.dart';
import 'package:form_data/pages/FarmerFieldPage.dart';
import 'package:form_data/pages/HomePage.dart';
import 'package:form_data/pages/LoginPage.dart';
import 'package:form_data/pages/ProfilePage.dart';
import 'package:form_data/pages/SettingPage.dart';
import 'package:form_data/pages/WelcomePage.dart';

import 'pages/PersonPage.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // '/':(context) => MyHomePage(),
        '/': (context) => const HomePage(),
        '/signup': (context) =>  PersonPage(),
        '/login': (context) => LoginPage(),
        '/welcome':(context) => const WelcomePage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/farmerfileds': (context) => const FarmerFieldPge(),
        '/createFarmField':(context) => CreateFarmFieldPage(),
      },
    );
  }
}
