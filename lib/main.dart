import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:talim/MainMenu/NavbarMenu.dart';
import 'package:talim/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'id_ID', null); // inisialisasi locale Indonesia

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844), // ukuran desain
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const Splashscreen(), // ganti dengan halaman awal
    ),
  );
}
