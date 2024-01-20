import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/screen_main.dart';
import 'screens/screen_details.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Azam Shoshin Task',
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 80, 163, 222),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 80, 163, 222),
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      routes: {
        '/': (context) => const ScreenMain(),
        '/screen_2': (context) => const ScreenDetails(),
      },
    );
  }
}
