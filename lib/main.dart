import 'package:flutter/material.dart';
import 'package:talim/MainMenu/NavbarMenu.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:talim/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'id_ID', null); // inisialisasi locale Indonesia
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: const NavbarMenu(),
      home: const Splashscreen(),
    );
  }
}
