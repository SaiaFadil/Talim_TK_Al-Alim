import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:talim/src/customColor.dart';

class JurnalHarian extends StatefulWidget {
  const JurnalHarian({super.key});

  @override
  State<JurnalHarian> createState() => _JurnalHarianState();
}

class _JurnalHarianState extends State<JurnalHarian> {
  DateTime selectedDate = DateTime.now();

  // Opsi ukuran font
  final List<double> fontSizes = [14, 16, 18, 20];
  int fontIndex = 1; // default sedang

  // Data JSON manual untuk testing
  final Map<String, dynamic> jurnalData = {
    "2025-08-10": {
      "catatan":
          "Amanda hari ini sangat aktif dan antusias dalam kegiatan belajar. Dia berhasil menyelesaikan tugas mewarnai dengan rapi dan membantu teman-temannya membereskan mainan. Saat istirahat, Amanda makan dengan lahap dan tidur siang dengan nyenyak. Secara keseluruhan, perkembangan Amanda sangat baik dan menunjukkan sikap yang positif.",
      "penulis": "Bu Sarah",
      "tips":
          "Lanjutkan aktivitas positif di rumah dengan memuji pencapaian anak dan dorong mereka untuk bercerita tentang hari mereka di sekolah."
    },
    "2025-08-09": {
      "catatan":
          "Amanda hari ini terlihat ceria dan bersemangat mengikuti semua kegiatan. Dia juga membantu guru dalam membagikan buku kepada teman-temannya.",
      "penulis": "Bu Sarah",
      "tips":
          "Ajak anak untuk menceritakan kembali pelajaran yang dia sukai di sekolah."
    }
  };

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  void changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  String getDateLabel() {
    DateTime now = DateTime.now();
    if (DateFormat('yyyy-MM-dd').format(selectedDate) ==
        DateFormat('yyyy-MM-dd').format(now)) {
      return "Hari ini";
    }
    return DateFormat('dd MMMM yyyy', 'id_ID').format(selectedDate);
  }

  void changeFontSize() {
    setState(() {
      fontIndex = (fontIndex + 1) % fontSizes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    String dateKey = DateFormat('yyyy-MM-dd').format(selectedDate);
    var data = jurnalData[dateKey];

    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Jurnal Harian",
            style: TextStyle(
                fontSize: 18,
                color: CustomColors.greyText,
                fontWeight: FontWeight.bold)),
        backgroundColor: CustomColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
          children: [
            // Navigasi Tanggal
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: CustomColors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_circle_left_outlined,
                        color: CustomColors.whiteColor),
                    onPressed: () => changeDate(-1),
                  ),
                  Column(
                    children: [
                      Text(
                        getDateLabel(),
                        style: TextStyle(
                            color: CustomColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        DateFormat('dd MMMM yyyy', 'id_ID')
                            .format(selectedDate),
                        style: TextStyle(color: CustomColors.whiteColor),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_circle_right_outlined,
                        color: CustomColors.whiteColor),
                    onPressed: () => changeDate(1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (data != null) ...[
              // Catatan Hari Ini
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.2),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.edit_outlined, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("Catatan Hari Ini",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          data["catatan"],
                          style: TextStyle(
                            fontSize: fontSizes[fontIndex],
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.blue, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            "Ditulis oleh: ${data["penulis"]}",
                            style: TextStyle(fontSize: fontSizes[fontIndex]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tips untuk Orang Tua
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.lightbulb_outline, color: Colors.green),
                          SizedBox(width: 8),
                          Text("Tips untuk Orang Tua",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        data["tips"],
                        style: TextStyle(
                          fontSize: fontSizes[fontIndex],
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else
              const Text(
                "Tidak ada catatan untuk tanggal ini",
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
