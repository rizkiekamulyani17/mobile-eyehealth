import 'package:Eye_Health/user_pages/about.dart';
import 'package:Eye_Health/user_pages/blog.dart';
import 'package:Eye_Health/user_pages/cek_kesehatan_mata.dart';
import 'package:Eye_Health/user_pages/chabot.dart';
import 'package:Eye_Health/user_pages/edit.dart';
import 'package:Eye_Health/user_pages/histori.dart';
import 'package:Eye_Health/user_pages/login.dart';
import 'package:Eye_Health/user_pages/monitoring.dart';
import 'package:Eye_Health/user_pages/profile.dart';
import 'package:Eye_Health/user_pages/profiledoktor.dart';
import 'package:Eye_Health/user_pages/rating.dart';
import 'package:Eye_Health/user_pages/register.dart';
import "package:flutter/material.dart";
import 'user_pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/profile': (context) => ProfilePage(),
        '/chatbot': (context) => ChatbotPage(),
        '/deteksi': (context) => CekKesehatanMata(),
        '/histori': (context) => HistoriPage(),
        '/blog': (context) => BlogPage(),
        '/profiledokter': (context) => ProfileDoktorkPage(),
        '/about': (context) => AboutPage(),
        '/edit': (context) => EditProfilePage(),
        '/rating': (context) => RatingPieChart(),
        '/monitoring': (context) => MonitoringPage(),
      },
    );
  }
}
