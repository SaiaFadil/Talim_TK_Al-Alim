import 'package:flutter/material.dart';
import 'package:talim/MainMenu/SubMenuBeranda/DetailSiswa.dart';
import 'package:talim/MainMenu/subMenuProfile/DetailProfil.dart';
 
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';

class Profilepage extends StatelessWidget {
  Profilepage({Key? key}) : super(key: key);

  // Dummy JSON
  final Map<String, dynamic> profilData = {
    "nama": "Fatima",
    "role": "Orang Tua",
    "telepon": "081234567890",
    "avatar": "null"
  };

  final List<Map<String, dynamic>> menuItems = [
    {
      "icon": Icons.person_outline,
      "label": "Informasi Akun",
      "page": DetailProfil(),
    },
    {
      "icon": Icons.lock_outline,
      "label": "Ketentuan & Privasi",
      "page": KetentuanPrivasiPage(),
    },
    {
      "icon": Icons.help_outline,
      "label": "Bantuan & Dukungan",
      "page": BantuanDukunganPage(),
    },
    {
      "icon": Icons.info_outline,
      "label": "Tentang Aplikasi",
      "page": TentangAplikasiPage(),
    },
    {
      "icon": Icons.logout,
      "label": "Keluar",
      "page": LogoutPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Profil",
          style: CustomText.TextSfProBold(18, CustomColors.blackColor),
        ),
      ),
      body: Column(
        children: [
          // Bagian profil pengguna
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: (profilData["avatar"] == null ||
                          profilData["avatar"].toString().isEmpty ||
                          profilData["avatar"].toString() == "null")
                      ? const AssetImage('assets/images/logo.png')
                          as ImageProvider
                      : NetworkImage(profilData["avatar"]),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profilData["nama"],
                      style:
                          CustomText.TextSfProBold(16, CustomColors.blackColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${profilData["role"]}: ${profilData["telepon"]}",
                      style: CustomText.TextSfPro(14, CustomColors.greyText),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          // Menu
          Expanded(
            child: ListView.separated(
              itemCount: menuItems.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey.shade300),
              itemBuilder: (context, index) {
                var item = menuItems[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item["page"]),
                    );
                  },
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item["icon"],
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    item["label"],
                    style:
                        CustomText.TextSfProBold(14, CustomColors.blackColor),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 16),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// Dummy Halaman Tujuan
class InformasiAkunPage extends StatelessWidget {
  const InformasiAkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Informasi Akun")),
      body: const Center(child: Text("Halaman Informasi Akun")),
    );
  }
}

class KetentuanPrivasiPage extends StatelessWidget {
  const KetentuanPrivasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ketentuan & Privasi")),
      body: const Center(child: Text("Halaman Ketentuan & Privasi")),
    );
  }
}

class BantuanDukunganPage extends StatelessWidget {
  const BantuanDukunganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bantuan & Dukungan")),
      body: const Center(child: Text("Halaman Bantuan & Dukungan")),
    );
  }
}

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tentang Aplikasi")),
      body: const Center(child: Text("Halaman Tentang Aplikasi")),
    );
  }
}

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keluar")),
      body: const Center(child: Text("Konfirmasi Logout")),
    );
  }
}
