import 'package:flutter/material.dart';
import 'package:talim/MainMenu/SubMenuBeranda/SubMenuPembayaran/PembayaranLainnya.dart';
import 'package:talim/MainMenu/SubMenuBeranda/SubMenuPembayaran/PembayaranSPP.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';
import 'package:talim/src/pageTransition.dart';

class PembayaranSiswa extends StatefulWidget {
  const PembayaranSiswa({Key? key}) : super(key: key);

  @override
  State<PembayaranSiswa> createState() => _PembayaranSiswaState();
}

class _PembayaranSiswaState extends State<PembayaranSiswa> {
  double fontSize = 14;

  void changeFontSize() {
    setState(() {
      if (fontSize == 14) {
        fontSize = 16;
      } else if (fontSize == 16) {
        fontSize = 18;
      } else if (fontSize == 18) {
        fontSize = 20;
      } else {
        fontSize = 14;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        backgroundColor: CustomColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Pembayaran",
          style:
              CustomText.TextSfProBold(fontSize + 6, CustomColors.blackColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields, color: Colors.black),
            onPressed: changeFontSize,
            tooltip: "Ubah ukuran font",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Pembayaran
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors.primarySoft),
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue.shade50.withOpacity(0.4),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: CustomColors.primarySoft,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.info_outline, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Pembayaran",
                          style: CustomText.TextSfProBold(
                              fontSize, CustomColors.blackColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Untuk melakukan pembayaran, silahkan datang ke admin sekolah atau hubungi melalui kontak dibawah ini. Admin akan membantu proses pembayaran dan konfirmasi.",
                          style: CustomText.TextSfPro(
                              fontSize - 2, CustomColors.blackColor),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue.shade200),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.person, color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Admin TK Al-Alim",
                                      style: CustomText.TextSfProBold(
                                          fontSize - 1,
                                          CustomColors.blackColor),
                                    ),
                                    Text(
                                      "0822-9876-6789",
                                      style: CustomText.TextSfPro(fontSize - 2,
                                          CustomColors.blackColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Catatan: ",
                                  style: CustomText.TextSfProBold(
                                      fontSize - 2, CustomColors.blackColor),
                                ),
                                TextSpan(
                                  text:
                                      "Jam operasional admin Senin-Jumat 07.00-15.00 WIB",
                                  style: CustomText.TextSfPro(
                                      fontSize - 2, CustomColors.blackColor),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Kategori Pembayaran
            Text(
              "Pilih Kategori Pembayaran",
              style: CustomText.TextSfProBold(
                  fontSize + 2, CustomColors.blackColor),
            ),
            const SizedBox(height: 12),

            // Tombol SPP
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, SmoothPageTransition(page: PembayaranSPP()));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.receipt_long,
                          color: Colors.blue, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SPP",
                            style: CustomText.TextSfProBold(
                                fontSize + 1, CustomColors.blackColor),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Sumbangan Pembinaan Pendidikan Per Bulan",
                            style: CustomText.TextSfPro(
                                fontSize - 2, CustomColors.greyText),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.grey, size: 16)
                  ],
                ),
              ),
            ),

            // Tombol Pembayaran Lainnya
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, SmoothPageTransition(page: PembayaranLainnya()));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.list_alt,
                          color: Colors.blue, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pembayaran Lainnya",
                            style: CustomText.TextSfProBold(
                                fontSize + 1, CustomColors.blackColor),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Uang pembangunan, kegiatan, seragam dan lain-lain",
                            style: CustomText.TextSfPro(
                                fontSize - 2, CustomColors.greyText),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.grey, size: 16)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
