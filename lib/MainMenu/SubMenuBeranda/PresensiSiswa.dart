import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talim/src/customColor.dart';

class PresensiSiswa extends StatefulWidget {
  const PresensiSiswa({super.key});

  @override
  State<PresensiSiswa> createState() => _PresensiSiswaState();
}

class _PresensiSiswaState extends State<PresensiSiswa> {
  DateTime currentMonth = DateTime.now();

  // Data JSON manual untuk testing
  final Map<String, dynamic> presensiData = {
    "2025-07": {
      "hadir": [
        {"tanggal": "2025-01-02", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-03", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-04", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-05", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-06", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-07", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-08", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-09", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-10", "masuk": "07:30", "keluar": "11:30"},
        {"tanggal": "2025-01-11", "masuk": "07:30", "keluar": "11:30"},
      ],
      "sakit": 1,
      "alpha": 0,
      "izin": 0,
      "totalHari": 11
    }
  };

  void changeMonth(int change) {
    setState(() {
      currentMonth =
          DateTime(currentMonth.year, currentMonth.month + change, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    String monthKey =
        "${currentMonth.year.toString().padLeft(4, '0')}-${currentMonth.month.toString().padLeft(2, '0')}";
    var data = presensiData[monthKey];

    int hadirCount = data?["hadir"]?.length ?? 0;
    int sakitCount = data?["sakit"] ?? 0;
    int alphaCount = data?["alpha"] ?? 0;
    int izinCount = data?["izin"] ?? 0;
    int totalHari = data?["totalHari"] ?? 1;

    double persentase = (hadirCount / totalHari) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Presensi", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pilih bulan
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 16),
                    onPressed: () => changeMonth(-1),
                  ),
                  Flexible(
                    child: Text(
                      DateFormat("MMMM yyyy", "id_ID").format(currentMonth),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => changeMonth(1),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hari hadir & persentase
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            "$hadirCount",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text("Hari Hadir"),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            "${persentase.toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.secondary,
                            ),
                          ),
                          const Text("Tingkat Kehadiran"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Ringkasan Kehadiran
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Ringkasan Kehadiran",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        _summaryItem(
                            "Sakit", sakitCount, Colors.orange.shade100),
                        _summaryItem("Alpha", alphaCount, Colors.red.shade100),
                        _summaryItem("Izin", izinCount, Colors.blue.shade100),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text("Riwayat Presensi",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              // ListView di dalam SingleChildScrollView → pakai shrinkWrap + physics
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hadirCount,
                itemBuilder: (context, index) {
                  var item = data?["hadir"]?[index];
                  DateTime tgl = DateTime.parse(item["tanggal"]);
                  return Card(
                    color: CustomColors.whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading:
                          const Icon(Icons.check_circle, color: Colors.blue),
                      title: Text(
                        DateFormat("EEEE, d MMM yyyy", "id_ID").format(tgl),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "Masuk: ${item["masuk"]}   Keluar: ${item["keluar"]}",
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text("Hadir",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryItem(String label, int count, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text("$label ($count Hari)"),
    );
  }
}
