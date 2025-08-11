import 'package:flutter/material.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';

class DetailSiswa extends StatelessWidget {
  final Map<String, dynamic> siswaData = {
    "nama": "Keenan Smith",
    "kelas": "TK A1",
    "foto": "null",
    "nisn": "0078653930662",
    "tanggal_lahir": "06 Januari 2004",
    "jenis_kelamin": "Laki-laki",
    "alamat": "Jl. Mawar No.12 Kota Bandung",
    "tanggal_masuk": "01 Juli 2022",
    "orang_tua": {
      "nama": "Amanda Keith",
      "status": "Orang Tua",
      "hubungan": "Ibu",
      "no_telp": "085301416756"
    }
  };

  DetailSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        backgroundColor: CustomColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: CustomColors.blackColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Data Siswa",
          style: CustomText.TextSfProBold(14, CustomColors.blackColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Foto + Nama + Kelas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: CustomColors.greyBackground2,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: CustomColors.secondary),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: CustomColors.secondary,
                    backgroundImage: (siswaData["foto"].toString() != null &&
                            siswaData["foto"].toString().isNotEmpty)
                        ? NetworkImage(siswaData["foto"])
                        : null,
                    child: (siswaData["foto"] == null ||
                            siswaData["foto"].toString().isEmpty)
                        ? Icon(Icons.person,
                            color: CustomColors.whiteColor, size: 40)
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    siswaData["nama"],
                    style:
                        CustomText.TextSfProBold(16, CustomColors.blackColor),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: CustomColors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      siswaData["kelas"],
                      style:
                          CustomText.TextSfProBold(12, CustomColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Informasi Pribadi
            buildSection(
              title: "Informasi Pribadi",
              icon: Icons.person_outline,
              children: [
                buildRowInfo("NISN", siswaData["nisn"]),
                buildRowInfo("Tanggal Lahir", siswaData["tanggal_lahir"]),
                buildRowInfo("Jenis Kelamin", siswaData["jenis_kelamin"]),
                buildRowInfo("Alamat", siswaData["alamat"]),
                buildRowInfo("Tanggal Masuk", siswaData["tanggal_masuk"]),
              ],
            ),
            const SizedBox(height: 20),

            // Informasi Orang Tua/Wali
            buildSection(
              title: "Informasi Orang Tua/Wali",
              icon: Icons.family_restroom_outlined,
              children: [
                buildRowInfo("Nama", siswaData["orang_tua"]["nama"]),
                buildRowInfo("Status", siswaData["orang_tua"]["status"]),
                buildRowInfo("Hubungan", siswaData["orang_tua"]["hubungan"]),
                buildRowInfo(
                    "Nomor Telepon", siswaData["orang_tua"]["no_telp"]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CustomColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: CustomColors.greyBackground2,
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: CustomColors.greyBackground2),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: CustomColors.secondary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: CustomText.TextSfProBold(14, CustomColors.blackColor),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget buildRowInfo(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CustomColors.greyBackground2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: CustomText.TextSfProBold(13, CustomColors.greyText),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: CustomText.TextSfProBold(13, CustomColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
