import 'package:flutter/material.dart';
import 'package:flutter_codigo4_weather/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme().apply(
          bodyColor: Colors.white,
        ),
      ),
      home: HomePage(),
    );
  }
}
