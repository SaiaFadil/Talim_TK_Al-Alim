import 'package:flutter/material.dart';
import 'package:talim/MainMenu/SubMenuBeranda/DetailSiswa.dart';
import 'package:talim/MainMenu/SubMenuBeranda/JurnalHarian.dart';
import 'package:talim/MainMenu/SubMenuBeranda/PembayaranSiswa.dart';
import 'package:talim/MainMenu/SubMenuBeranda/PresensiSiswa.dart';
import 'package:talim/MainMenu/SubMenuBeranda/RaportSiswa.dart';
import 'package:talim/Models/child_model.dart';

import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';
import 'package:talim/src/pageTransition.dart';

class ChildCard extends StatefulWidget {
  final ChildModel child;

  const ChildCard({super.key, required this.child});

  @override
  State<ChildCard> createState() => _ChildCardState();
}

class _ChildCardState extends State<ChildCard> with TickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: CustomColors.primarySoft,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Foto anak
                  CircleAvatar(
                    foregroundColor: CustomColors.greyText,
                    radius: 18,
                    child: Image.asset('assets/images/ic_jumlah_siswa.png',
                        height: 15),
                    backgroundColor: CustomColors.greyBackground2,
                  ),
                  const SizedBox(width: 12),
                  // Nama & Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.child.name,
                          style: CustomText.TextSfProBold(
                              16, CustomColors.blackColor),
                        ),
                        Text(
                          '${widget.child.className} - NISN: ${widget.child.nisn}',
                          style:
                              CustomText.TextSfPro(14, CustomColors.greyText),
                        ),
                      ],
                    ),
                  ),
                  // Icon expand/collapse dengan animasi rotasi
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey.shade600,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expand area dengan animasi tinggi
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _isExpanded ? 1 : 0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return ClipRect(
                child: Align(
                  heightFactor: value, // animasi tinggi
                  child: Opacity(
                    opacity: value, // animasi fade
                    child: Transform.scale(
                      scale: value, // animasi zoom
                      alignment: Alignment.topCenter,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                buildMenuCard(
                  title: "Data Diri Siswa",
                  subtitle: "Informasi lengkap siswa",
                  icon: Icons.person_outline,
                  iconColor: Colors.blue,
                  idSiswa: widget.child.id.toString(),
                  onTap: (id) {
                    Navigator.push(
                        context, SmoothPageTransition(page: DetailSiswa()));
                    debugPrint("Klik Data Diri untuk ID: $id");
                  },
                ),
                buildMenuCard(
                  title: "Jurnal Harian",
                  subtitle: "Catatan aktivitas harian",
                  icon: Icons.edit_note_outlined,
                  iconColor: Colors.orange,
                  idSiswa: widget.child.id.toString(),
                  onTap: (id) {
                    Navigator.push(
                        context, SmoothPageTransition(page: JurnalHarian()));
                    debugPrint("Klik Jurnal Harian untuk ID: $id");
                  },
                ),
                buildMenuCard(
                  title: "Presensi",
                  subtitle: "Kehadiran harian",
                  icon: Icons.check_circle_outline,
                  iconColor: Colors.green,
                  idSiswa: widget.child.id.toString(),
                  onTap: (id) {
                    Navigator.push(
                        context, SmoothPageTransition(page: PresensiSiswa()));
                    debugPrint("Klik Absensi untuk ID: $id");
                  },
                ),
                buildMenuCard(
                  title: "Nilai Rapot",
                  subtitle: "Perkembangan akademik",
                  icon: Icons.contact_page_outlined,
                  iconColor: Colors.purpleAccent,
                  idSiswa: widget.child.id.toString(),
                  onTap: (id) {
                    Navigator.push(
                        context, SmoothPageTransition(page: RaportSiswa()));
                    debugPrint("Klik rapot untuk ID: $id");
                  },
                ),
                buildMenuCard(
                  title: "Pembayaran",
                  subtitle: "SPP, uang pembangunan, dll",
                  icon: Icons.payments_outlined,
                  iconColor: Colors.red,
                  idSiswa: widget.child.id.toString(),
                  onTap: (id) {
                    Navigator.push(
                        context, SmoothPageTransition(page: PembayaranSiswa()));
                    debugPrint("Klik pembayaran untuk ID: $id");
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Widget untuk tombol menu
Widget buildMenuCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color iconColor,
  required String idSiswa,
  required Function(String id) onTap,
}) {
  return GestureDetector(
    onTap: () => onTap(idSiswa),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ikon dalam lingkaran
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 14),
          // Teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
