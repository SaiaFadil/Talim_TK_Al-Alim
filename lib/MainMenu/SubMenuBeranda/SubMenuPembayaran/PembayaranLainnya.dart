import 'package:flutter/material.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';

class PembayaranLainnya extends StatelessWidget {
  PembayaranLainnya({Key? key}) : super(key: key);

  // Dummy JSON data (Lunas & Belum Bayar)
  final Map<String, List<Map<String, dynamic>>> dataLainnya = {
    "Lunas": [
      {
        "bulan": "Lainnya Bulan Oktober",
        "jatuhTempo": "10 Januari 2025",
        "tanggalBayar": "08 Juli 2025",
        "jumlah": 750000
      },
      {
        "bulan": "Lainnya Bulan November",
        "jatuhTempo": "10 Februari 2025",
        "tanggalBayar": "10 Juli 2025",
        "jumlah": 750000
      },
    ],
    "Belum Bayar": [
      {
        "bulan": "Lainnya Bulan Desember",
        "jatuhTempo": "10 Maret 2025",
        "jumlah": 750000
      },
      {
        "bulan": "Lainnya Bulan Januari",
        "jatuhTempo": "10 April 2025",
        "jumlah": 750000
      },
    ],
  };

  String formatRupiah(int? value) {
    if (value == null) return "Rp 0";
    final s = value.toString();
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return 'Rp ${s.replaceAllMapped(reg, (m) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
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
            "Pembayaran Lainnya",
            style: CustomText.TextSfProBold(18, CustomColors.blackColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // TabBar
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

              // Tab Content
              Expanded(
                child: TabBarView(
                  children: [
                    _buildListLainnya(dataLainnya["Lunas"] ?? [], true),
                    _buildListLainnya(dataLainnya["Belum Bayar"] ?? [], false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListLainnya(List<Map<String, dynamic>> list, bool isLunas) {
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
        return _buildLainnyaCard(item, isLunas);
      },
    );
  }

  Widget _buildLainnyaCard(Map<String, dynamic> item, bool isLunas) {
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
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 12),

            // Detail
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          bulan,
                          style: CustomText.TextSfProBold(
                              14, CustomColors.blackColor),
                        ),
                      ),
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

                  // Jatuh tempo
                  Text(
                    "Jatuh tempo: $jatuh",
                    style: CustomText.TextSfPro(12, CustomColors.greyText),
                  ),

                  // Tanggal bayar jika lunas
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

            // Jumlah
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
