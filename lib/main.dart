import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'AI Study Assistant',

      theme: ThemeData(

        brightness: Brightness.dark,

        scaffoldBackgroundColor: const Color(0xFF0F0F1A),

        primaryColor: const Color(0xFF8B5CF6),

        fontFamily: 'Roboto',

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F0F1A),
          elevation: 0,
        ),
      ),

        home: const HomeScreen(),
    );
  }
}