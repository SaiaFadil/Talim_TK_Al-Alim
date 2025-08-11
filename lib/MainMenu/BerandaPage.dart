import 'package:flutter/material.dart';
import 'package:talim/MainMenu/SubMenuBeranda/SemuaAgenda.dart';
import 'package:talim/MainMenu/SubMenuBeranda/SemuaPengumuman.dart';
import 'package:talim/Models/child_model.dart';
import 'package:talim/SendApi/AnakAPI.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/child_card.dart';
import 'package:talim/src/customColor.dart';
import 'package:talim/src/pageTransition.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late Future<List<ChildModel>> _futureChildren;

  // Data manual untuk testing
  List<Map<String, dynamic>> agendaList = [
    {
      "judul": "Acara Pondok Ramadhan",
      "tanggal": "15 Agustus 2025",
      "icon": Icons.calendar_today,
    }
  ];

  List<Map<String, dynamic>> pengumumanList = [
    {
      "judul": "Penerimaan Peserta Didik Baru",
      "deskripsi":
          "Penerimaan peserta didik baru dimulai pada tanggal 10 Agustus 2025",
      "icon": Icons.article_outlined,
    }
  ];

  List<Map<String, dynamic>> dokumentasiList = [
    {
      "judul": "Kegiatan Belajar Mengajar",
      "gambar":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkd1hUcRC3ClGHniTL_o3fu297C-BZsdxqFA&s"
    },
    {
      "judul": "Kegiatan Belajar Mengajar",
      "gambar":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkd1hUcRC3ClGHniTL_o3fu297C-BZsdxqFA&s"
    }
  ];

  @override
  void initState() {
    super.initState();
    _futureChildren = Anakapi.getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    _headerCard(),
                    SizedBox(height: 16),

                    // Bagian Anak-anak
                    Text("Anak-anak Saya",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    FutureBuilder<List<ChildModel>>(
                      future: _futureChildren,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text('Terjadi kesalahan: ${snapshot.error}');
                        }
                        final children = snapshot.data ?? [];
                        return Column(
                          children: children
                              .map((child1) => ChildCard(child: child1))
                              .toList(),
                        );
                      },
                    ),
                    SizedBox(height: 15),

                    // Agenda Sekolah
                    if (agendaList.isNotEmpty) _buildAgendaSection(),

                    // Pengumuman
                    if (pengumumanList.isNotEmpty) _buildPengumumanSection(),

                    // Dokumentasi
                    if (dokumentasiList.isNotEmpty) _buildDokumentasiSection(),
                  ],
                ),
              ),
            ),

            // Header
            _buildHeaderBar(),
          ],
        ),
      ),
    );
  }

  // Widget Header Card
  Widget _headerCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/childrenDashboard.png', height: 150),
          SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hallo,\nIbu Fatima!",
                    style: CustomText.TextSfPro(20, CustomColors.whiteColor)),
                SizedBox(height: 10),
                Text("Pantau perkembangan anak Anda di TK Al-Alim",
                    style: CustomText.TextSfPro(14, CustomColors.whiteColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Header Bar dengan Notifikasi
  Widget _buildHeaderBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        elevation: 5,
        margin: EdgeInsets.zero,
        color: CustomColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Container(
                            height: 25,
                            width: 25,
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 5),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "TK Al-Alim",
                                style: CustomText.TextSfProBold(
                                    18, CustomColors.secondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Sistem Informasi Sekolah",
                          style:
                              CustomText.TextSfProBold(14, CustomColors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Lonceng notifikasi
            Container(
              margin: EdgeInsets.only(right: 20),
              child: PopupMenuButton<String>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                elevation: 6,
                onSelected: (value) {
                  print("Dipilih: $value");
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: "notif1",
                      child: Row(
                        children: [
                          Icon(Icons.campaign,
                              color: CustomColors.primary, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Pengumuman rapat guru besok",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "notif2",
                      child: Row(
                        children: [
                          Icon(Icons.schedule,
                              color: CustomColors.primary, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Jadwal ujian minggu depan",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(Icons.notifications,
                        size: 28, color: CustomColors.primary),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bagian Agenda Sekolah
  Widget _buildAgendaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Agenda Sekolah", SemuaAgenda()),
        SizedBox(height: 8),
        ...agendaList.map((item) => Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: CustomColors.grey, width: 0.7),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: CustomColors.secondary.withOpacity(0.1),
                  child: Icon(item["icon"], color: CustomColors.secondary),
                ),
                title: Text(item["judul"]),
                subtitle: Text(item["tanggal"]),
              ),
              color: CustomColors.whiteColor,
            )),
        SizedBox(height: 16),
      ],
    );
  }

  // Bagian Pengumuman
  Widget _buildPengumumanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Pengumuman", SemuaPengumuman()),
        SizedBox(height: 8),
        ...pengumumanList.map((item) => Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: CustomColors.grey, width: 0.7),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: CustomColors.secondary.withOpacity(0.1),
                  child: Icon(item["icon"], color: CustomColors.secondary),
                ),
                title: Text(item["judul"]),
                subtitle: Text(item["deskripsi"]),
              ),
              color: CustomColors.whiteColor,
            )),
        SizedBox(height: 16),
      ],
    );
  }

  // Bagian Dokumentasi
  Widget _buildDokumentasiSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Dokumentasi Kegiatan',
              style: CustomText.TextSfProBold(14, CustomColors.blackColor),
            ),
            const SizedBox(width: 8), // jarak kecil sebelum garis
            Expanded(
              child: Container(
                height: 1.2,
                color: CustomColors.primarySoft,
              ),
            ),
            const SizedBox(width: 8), // jarak kecil setelah garis
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dokumentasiList.length,
            separatorBuilder: (_, __) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              var item = dokumentasiList[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.network(item["gambar"],
                        width: 300, height: 180, fit: BoxFit.cover),
                    Container(
                      width: 300,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      color: Colors.black.withOpacity(0.4),
                      child: Text(item["judul"],
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Header untuk tiap section
  Widget _sectionHeader(String title, Widget pages) {
    return Row(
      children: [
        Text(
          title,
          style: CustomText.TextSfProBold(14, CustomColors.blackColor),
        ),
        const SizedBox(width: 8), // jarak kecil sebelum garis
        Expanded(
          child: Container(
            height: 1.2,
            color: CustomColors.primarySoft,
          ),
        ),
        const SizedBox(width: 8), // jarak kecil setelah garis
        TextButton(
          child: Text(
            "Lihat Semua",
            style: CustomText.TextSfProBold(14, CustomColors.secondary),
          ),
          onPressed: () {
            Navigator.push(context, SmoothPageTransition(page: pages));
          },
        ),
      ],
    );
  }
}
