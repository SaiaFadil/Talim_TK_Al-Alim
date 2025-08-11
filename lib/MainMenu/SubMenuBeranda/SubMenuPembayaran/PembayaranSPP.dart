import 'package:flutter/material.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';

class PembayaranSPP extends StatefulWidget {
  const PembayaranSPP({Key? key}) : super(key: key);

  @override
  State<PembayaranSPP> createState() => _PembayaranSPPState();
}

class _PembayaranSPPState extends State<PembayaranSPP> {
  int semester = 1;

  // Dummy JSON data per semester (Lunas & Belum Bayar)
  final Map<int, Map<String, List<Map<String, dynamic>>>> dataSPP = {
    1: {
      "Lunas": [
        {
          "bulan": "SPP Bulan Oktober",
          "jatuhTempo": "10 Januari 2025",
          "tanggalBayar": "08 Juli 2025",
          "jumlah": 750000
        },
        {
          "bulan": "SPP Bulan November",
          "jatuhTempo": "10 Februari 2025",
          "tanggalBayar": "10 Juli 2025",
          "jumlah": 750000
        },
      ],
      "Belum Bayar": [
        {
          "bulan": "SPP Bulan Desember",
          "jatuhTempo": "10 Maret 2025",
          "jumlah": 750000
        }
      ],
    },
    2: {
      "Lunas": [
        {
          "bulan": "SPP Bulan Januari",
          "jatuhTempo": "10 April 2025",
          "tanggalBayar": "05 Februari 2025",
          "jumlah": 750000
        },
      ],
      "Belum Bayar": [
        {
          "bulan": "SPP Bulan Februari",
          "jatuhTempo": "10 Mei 2025",
          "jumlah": 750000
        },
        {
          "bulan": "SPP Bulan Maret",
          "jatuhTempo": "10 Juni 2025",
          "jumlah": 750000
        }
      ],
    }
  };

  String getPeriode() {
    return semester == 1 ? "Juli - Desember 2025" : "Januari - Juni 2025";
  }

  String formatRupiah(int? value) {
    if (value == null) return "Rp 0";
    final s = value.toString();
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return 'Rp ${s.replaceAllMapped(reg, (m) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
    // Ensure semester key exists
    final dataForSemester = dataSPP[semester] ??
        {
          "Lunas": <Map<String, dynamic>>[],
          "Belum Bayar": <Map<String, dynamic>>[],
        };

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: CustomColors.greyBackground,
        appBar: AppBar(
          backgroundColor: CustomColors.whiteColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.blackColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "SPP",
            style: CustomText.TextSfProBold(18, CustomColors.blackColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // --- Semester card ---
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: CustomColors.greyBackground2),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school,
                            color: CustomColors.secondary, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Pilih Semester",
                            style: CustomText.TextSfProBold(
                                14, CustomColors.blackColor),
                          ),
                        ),

                        // Arrow left
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (semester > 1) semester--;
                            });
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: CustomColors.greyBackground,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: CustomColors.greyBackground2),
                            ),
                            child: Icon(Icons.chevron_left,
                                size: 18, color: CustomColors.blackColor),
                          ),
                        ),

                        const SizedBox(width: 8),
                        Text(
                          "Semester $semester",
                          style:
                              CustomText.TextSfPro(14, CustomColors.blackColor),
                        ),
                        const SizedBox(width: 8),

                        // Arrow right
                        InkWell(
                          onTap: () {
                            setState(() {
                              // assume only 2 semesters available in dummy
                              if (semester < 2) semester++;
                            });
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: CustomColors.greyBackground,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: CustomColors.greyBackground2),
                            ),
                            child: Icon(Icons.chevron_right,
                                size: 18, color: CustomColors.blackColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Periode: ${getPeriode()}",
                        style: CustomText.TextSfPro(12, CustomColors.greyText),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // --- TabBar (Lunas / Belum Bayar) ---
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicatorColor: CustomColors.secondary,
                  labelColor: CustomColors.secondary,
                  unselectedLabelColor: CustomColors.greyText,
                  labelStyle:
                      CustomText.TextSfProBold(14, CustomColors.secondary),
                  unselectedLabelStyle:
                      CustomText.TextSfPro(14, CustomColors.greyText),
                  tabs: const [
                    Tab(text: "Lunas"),
                    Tab(text: "Belum Bayar"),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // --- Tab content ---
              Expanded(
                child: TabBarView(
                  children: [
                    // LUNAS
                    _buildListSPP(dataForSemester["Lunas"] ?? [], true),

                    // BELUM BAYAR
                    _buildListSPP(dataForSemester["Belum Bayar"] ?? [], false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListSPP(List<Map<String, dynamic>> list, bool isLunas) {
    if (list.isEmpty) {
      return Center(
        child: Text(
          "Tidak ada data",
          style: CustomText.TextSfPro(14, CustomColors.greyText),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = list[index];
        return _buildSPPCard(item, isLunas);
      },
    );
  }

  Widget _buildSPPCard(Map<String, dynamic> item, bool isLunas) {
    // Safe reads with fallback
    final String bulan = (item['bulan'] ?? '-').toString();
    final String jatuh = (item['jatuhTempo'] ?? '-').toString();
    final String tanggalBayar = (item['tanggalBayar'] ?? '-').toString();
    final int? jumlahValue = item['jumlah'] is int
        ? item['jumlah'] as int
        : int.tryParse('${item['jumlah'] ?? ''}');

    final Color leftColor = isLunas ? CustomColors.secondary : CustomColors.red;
    final Color bgColor = isLunas
        ? CustomColors.primarySoft.withAlpha(10)
        : CustomColors.red.withOpacity(0.05);
    final IconData icon =
        isLunas ? Icons.check_circle_outline : Icons.cancel_outlined;
    final Color iconColor = isLunas ? CustomColors.secondary : CustomColors.red;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          bottom: BorderSide(color: leftColor, width: 0.5),
          right: BorderSide(color: leftColor, width: 0.5),
          top: BorderSide(color: leftColor, width: 0.5),
          left: BorderSide(color: leftColor, width: 4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon box
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),

            const SizedBox(width: 12),

            // details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title + badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          bulan,
                          style: CustomText.TextSfProBold(
                              14, CustomColors.blackColor),
                        ),
                      ),

                      // badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: leftColor, width: 1),
                        ),
                        child: Text(
                          isLunas ? "Lunas" : "Belum Bayar",
                          style: CustomText.TextSfPro(11, leftColor),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // jatuh tempo
                  Text(
                    "Jatuh tempo: $jatuh",
                    style: CustomText.TextSfPro(12, CustomColors.greyText),
                  ),

                  // tanggal bayar jika lunas
                  if (isLunas) ...[
                    const SizedBox(height: 4),
                    Text(
                      "Dibayar pada: $tanggalBayar",
                      style: CustomText.TextSfPro(12, leftColor),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 12),

            // amount
            Text(
              formatRupiah(jumlahValue),
              style: CustomText.TextSfProBold(14, CustomColors.blackColor),
            ),
          ],
        ),
      ),
    );
  }
}
