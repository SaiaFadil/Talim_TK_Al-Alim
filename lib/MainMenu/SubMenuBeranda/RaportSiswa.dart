import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';

class RaportSiswa extends StatefulWidget {
  const RaportSiswa({super.key});

  @override
  State<RaportSiswa> createState() => _RaportSiswaState();
}

class _RaportSiswaState extends State<RaportSiswa>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentSemester = 1;

  // JSON manual untuk testing (mock)
  final Map<String, dynamic> raportData = {
    "TK A": {
      "semester1": {
        "periode": "Juli - Desember 2025",
        "pdfUrl":
            "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
        "fileName": "raport_tka_sem1.pdf"
      },
      "semester2": {
        "periode": "Januari - Juni 2026",
        "pdfUrl":
            "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
        "fileName": "raport_tka_sem2.pdf"
      }
    },
    "TK B": {
      "semester1": {
        "periode": "Juli - Desember 2025",
        "pdfUrl":
            "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
        "fileName": "raport_tkb_sem1.pdf"
      },
    }
  };

  final Duration animDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void changeSemester(int delta) {
    setState(() {
      currentSemester += delta;
      if (currentSemester < 1) currentSemester = 1;
      if (currentSemester > 2) currentSemester = 2;
    });
  }

  Future<void> downloadPdfToAppDir(String url, String fileName) async {
    try {
      final res = await http.get(Uri.parse(url));
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(res.bodyBytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil diunduh: ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengunduh: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // aktif tab dihitung ulang di builder _buildTabContent
    // gunakan map di builder konten, tidak perlu variabel lokal 'data' di sini
    final bg = Colors.white;
    final primary = const Color(0xFF2D6BF6);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Nilai Rapot',
          style: CustomText.TextSfProBold(14, CustomColors.blackColor),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: primary,
          labelColor: primary,
          unselectedLabelColor: Colors.grey,
          onTap: (_) => setState(() {}),
          tabs: const [
            Tab(text: 'TK A'),
            Tab(text: 'TK B'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('TK A'),
          _buildTabContent('TK B'),
        ],
      ),
    );
  }

  Widget _buildTabContent(String tabKey) {
    String semesterKey = currentSemester == 1 ? 'semester1' : 'semester2';
    final data = raportData[tabKey]?[semesterKey];
    final primary = const Color(0xFF2D6BF6);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Pilih Semester Card
          AnimatedSwitcher(
            duration: animDuration,
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
                        .animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Container(
              key: ValueKey('semester-card-$currentSemester-$tabKey'),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.calendar_today, color: primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Semester',
                          style: CustomText.TextSfProBold(
                              14, CustomColors.blackColor),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.chevron_left),
                              onPressed: () => changeSemester(-1),
                            ),
                            Text(
                              'Semester $currentSemester',
                              style: CustomText.TextSfProBold(
                                  15, CustomColors.blackColor),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () => changeSemester(1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Periode: ${data?['periode'] ?? '-'}',
                          style:
                              CustomText.TextSfPro(14, CustomColors.greyText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // PDF Card (dotted border)
          GestureDetector(
            onTap: data != null && data['pdfUrl'] != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PDFPreviewPage(
                          title: data['fileName'] ?? 'Preview PDF',
                          pdfUrl: data['pdfUrl'],
                        ),
                      ),
                    );
                  }
                : null,
            child: DottedBorder(
              color: Colors.blue.shade300,
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              dashPattern: const [6, 6],
              strokeWidth: 1,
              child: Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue.shade50.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.picture_as_pdf,
                          color: Colors.blue, size: 32),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?['fileName'] ?? 'Tidak ada file',
                            style: CustomText.TextSfProBold(14,
                                (data != null) ? Colors.black : Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data?['pdfUrl'] ?? '—',
                            style:
                                CustomText.TextSfPro(14, CustomColors.greyText),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tombol Download & Preview
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: (data != null && data['pdfUrl'] != null)
                      ? () =>
                          downloadPdfToAppDir(data['pdfUrl'], data['fileName'])
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Download PDF',
                      style: CustomText.TextSfProBold(
                          14, CustomColors.whiteColor)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: (data != null && data['pdfUrl'] != null)
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PDFPreviewPage(
                                title: data['fileName'] ?? 'Preview PDF',
                                pdfUrl: data['pdfUrl'],
                              ),
                            ),
                          );
                        }
                      : null,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Preview',
                      style: CustomText.TextSfProBold(
                          14, CustomColors.blackColor)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Halaman preview PDF (zoom & pan support via Syncfusion)
class PDFPreviewPage extends StatelessWidget {
  final String pdfUrl;
  final String title;

  const PDFPreviewPage({
    super.key,
    required this.pdfUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Syncfusion dapat langsung memuat URL network dan menyediakan zoom & pan
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: CustomText.TextSfProBold(14, CustomColors.blackColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black54),
      ),
      body: SafeArea(
        child: SfPdfViewer.network(
          pdfUrl,
          canShowScrollHead: true,
          canShowScrollStatus: true,
        ),
      ),
    );
  }
}
