import 'package:flutter/material.dart';
 
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';
import 'package:talim/src/topnav.dart';

class Tentangapk extends StatelessWidget {
  const Tentangapk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Topnav(
          title: 'Tentang Aplikasi',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200,
              ),
              const SizedBox(height: 20),
              Text(
                'Aplikasi talim (ta`lim) (تعليم) yang berarti "pendidikan". adalah solusi inovatif dalam bentuk aplikasi mobile Android yang dikembangkan dengan teknologi Flutter, memberikan efisiensi dan performa ringan. Dirancang untuk dapat dijalankan dengan minimum RAM sebesar 2 GB dan versi Android 10, talim menawarkan fitur khusus untuk orang tua murid, seperti melihat presensi siswa, riwayat pembayaran, dan nilai rapor secara praktis melalui perangkat mobile. Dengan antarmuka yang sederhana dan ramah pengguna, Talim menjadi sarana pendukung komunikasi tidak langsung antara sekolah dan orang tua, demi mendukung keterlibatan aktif dalam proses pendidikan anak.',
                style: CustomText.TextArvo(14, CustomColors.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Text(
                    'Contact Developers : 089518917844',
                    style: CustomText.TextArvo(14, CustomColors.whiteColor),
                  ),
                  SizedBox(height: 5),
                  Text('Email : fadillahwahyunugraha@gmail.com',
                      style: CustomText.TextArvo(14, CustomColors.whiteColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
