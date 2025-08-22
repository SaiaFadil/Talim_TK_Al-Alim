import 'package:flutter/material.dart';
import 'package:talim/UserPages/loginPages.dart';
import 'package:talim/src/CustomButton.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';

class SliderP extends StatefulWidget {
  SliderP({Key? key}) : super(key: key);
  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  final ScrollController _scrollController = ScrollController();
  bool _isHeaderVisible = true;
  int activeIndex = 0;
  final PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.97,
  );
  final urlImages = [
    'assets/images/Robotik.jpg',
    'assets/images/Menggambar.jpg',
    'assets/images/Mewarnai.jpg',
  ];
  final deskripsi = [
    "Dengan robotik, anak dapat membuat robot sesuai dengan imajinasi mereka.",
    "Dengan menggambar, anak dapat menggambar dan membuat desain sesuai dengan imajinasi mereka.",
    "Dengan mewarnai, anak dapat mewarnai dan membuat desain sesuai dengan imajinasi mereka."
  ];
  final textTombol = ["Robotik", "Menggambar", "Mewarnai"];
  final judul = ["ROBOTIK", "MENGGAMBAR", "MEWARNAI"];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 300 && _isHeaderVisible) {
      setState(() => _isHeaderVisible = false);
    } else if (_scrollController.offset <= 300 && !_isHeaderVisible) {
      setState(() => _isHeaderVisible = true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> Pindah() async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1500),
        pageBuilder: (context, animation, secondaryAnimation) => Login(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.305,
                        child: PageView.builder(
                          controller: controller,
                          physics: const PageScrollPhysics(),
                          itemCount: urlImages.length,
                          onPageChanged: (index) =>
                              setState(() => activeIndex = index),
                          itemBuilder: (context, index) {
                            double scale = activeIndex == index ? 1 : 0.95;
                            return Transform.scale(
                              scale: scale,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02,
                                    vertical: screenHeight * 0.02),
                                child: buildImage(
                                  urlImages[index],
                                  judul[index],
                                  deskripsi[index],
                                  index,
                                  screenHeight,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildIndicator(),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            buildProfileGrid(screenWidth),
                            const SizedBox(height: 10),
                            buildInfoCard("Kenapa harus TK Al-Alim?", [
                              [
                                "Kurikulum Terpadu",
                                "Lorem ipsum akdbidj shsvtgssLorem ipsum akdbidj shsvtgss",
                                Icons.check_circle_outline
                              ],
                              [
                                "Guru Berpengalaman",
                                "Lorem ipsum akdbidj shsvtgss",
                                Icons.people_outline
                              ],
                              [
                                "Metode bermain Edukatif",
                                "Lorem ipsum akdbidj shsvtgss ",
                                Icons.school_outlined
                              ],
                            ]),
                            const SizedBox(height: 10),
                            buildVisiMisiCard("Visi & Misi", [
                              [
                                "Visi",
                                "Membina dan mengembangkan potensi anak usia dini yang berakhlak mulia, sehat, cerdas, ceria, serta peduli dengan lingkungan sekitar.",
                                Icons.check_circle_outlined
                              ],
                              [
                                "Misi",
                                "Melaksanakan pembelajaran aktif, kreatif, efektif, dan inovatif. Membimbing anak untuk berakhlak mulia. Menciptakan suasana belajar menyenangkan.",
                                Icons.check_circle_outlined
                              ],
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text("Akses Layanan TK Al-Alim",
                          style: CustomText.TextSfProBold(
                              16, CustomColors.secondary)),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Masuk untuk mengakses informasi dan layanan\nTK Al-Alim\n(Untuk Orang Tua)",
                          style: CustomText.TextSfProBold(
                              12, CustomColors.greyText),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: CustomButton.DefaultButton(CustomColors.primary),
                        onPressed: Pindah,
                        child: Text("Masuk",
                            style: CustomText.TextSfProBold(
                                20, CustomColors.whiteColor)),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOut,
              top: _isHeaderVisible ? 0 : -150,
              left: 0,
              right: 0,
              child: headerWidget(screenWidth, screenHeight),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWidget(double screenWidth, double screenHeight) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      color: CustomColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: screenWidth * 0.03),
                Image.asset(
                  'assets/images/logo.png',
                  height: screenHeight * 0.04,
                  width: screenHeight * 0.04,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TK Al-Alim",
                      style:
                          CustomText.TextSfProBold(18, CustomColors.secondary),
                    ),
                    Text(
                      "Sistem Informasi Sekolah",
                      style:
                          CustomText.TextSfProBold(14, CustomColors.greyText),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: ElevatedButton(
                  style: CustomButton.miniButton(CustomColors.primarySoft),
                  onPressed: Pindah,
                  child: Text(
                    "Masuk",
                    style: CustomText.TextSfProBold(14, CustomColors.secondary),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(urlImages.length, (index) {
          return GestureDetector(
            onTap: () => controller.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: activeIndex == index
                    ? CustomColors.blackColor
                    : CustomColors.grey,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      );
  Widget buildProfileGrid(double screenWidth) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: screenWidth < 630 ? 2 : 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: screenWidth < 400 ? 1 : 1.2,
      children: [
        profileTile("ic_jumlah_siswa.png", "15+", "Jumlah Siswa", "Anak didik"),
        profileTile("ic_akreditasi.png", "-", "Akreditasi", "Belum Terisi"),
        profileTile("ic_program.png", "3", "Program", "Ekstrakurikuler"),
        profileTile("ic_pengajar.png", "15+", "Pengajar", "Pengajar Kompeten"),
      ],
    );
  }

  Widget profileTile(
      String imgIcon, String hasil, String jumlah, String label) {
    return Card(
      elevation: 1,
      color: CustomColors.whiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: CustomColors.grey, width: 0.6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/' + imgIcon, scale: 3),
          SizedBox(height: 6),
          Text(hasil,
              style: CustomText.TextSfProBold(19, CustomColors.secondary)),
          Text(jumlah,
              style: CustomText.TextSfProBold(15, CustomColors.blackColor)),
          Text(label,
              style: CustomText.TextSfProBold(
                  13, CustomColors.blackColor.withOpacity(0.5))),
        ],
      ),
    );
  }

  Widget buildInfoCard(String title, List<List<dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: CustomText.TextSfProBold(16, CustomColors.secondary),
          ),
        ),
        const SizedBox(height: 10),
        ...items.map((item) => Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: CustomColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  bottom: BorderSide(color: CustomColors.secondary, width: 0.5),
                  right: BorderSide(color: CustomColors.secondary, width: 0.5),
                  top: BorderSide(color: CustomColors.secondary, width: 0.5),
                  left: BorderSide(color: CustomColors.secondary, width: 4),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Garis biru di kiri
                  Container(
                    width: 5,
                    decoration: BoxDecoration(
                      color: CustomColors.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            item[2],
                            size: 28,
                            color: CustomColors.secondary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Judul biru
                                Text(
                                  item[0],
                                  style: CustomText.TextSfProBold(
                                      14, CustomColors.secondary),
                                ),
                                const SizedBox(height: 4),
                                // Deskripsi
                                Text(
                                  item[1],
                                  style: CustomText.TextSfPro(
                                      12, Colors.grey[700]!),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Widget buildVisiMisiCard(String title, List<List<dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(title,
              textAlign: TextAlign.center,
              style: CustomText.TextSfProBold(16, CustomColors.secondary)),
        ),
        const SizedBox(height: 10),
        ...items.map((item) => Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    width: 1,
                    color: CustomColors.grey.withOpacity(0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item[2], size: 24, color: CustomColors.secondary),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          item[1],
                          style: CustomText.TextSfPro(12, Colors.grey[700]!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

Widget buildImage(
  String urlImage,
  String judul,
  String deskripsi,
  int index,
  double screenHeight,
) {
  return Card(
    color: CustomColors.whiteColor,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        // Gambar
        Image.asset(
          urlImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: screenHeight * 0.305,
        ),

        // Overlay gradasi
        Container(
          width: double.infinity,
          height: screenHeight * 0.305,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
                Colors.black.withOpacity(0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // Judul di tengah
        Positioned.fill(
          child: Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Text(
              judul,
              style: TextStyle(
                color: CustomColors.whiteColor,
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        // Container bawah untuk deskripsi
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black.withOpacity(0.5), // abu/hitam transparan
            child: Text(
              deskripsi,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.018,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ),
      ],
    ),
  );
}
