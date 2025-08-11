import 'package:flutter/material.dart';
import 'package:talim/SendApi/Server.dart';
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
  ScrollController _scrollController = ScrollController();
  bool _isHeaderVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 600 && _isHeaderVisible) {
      setState(() {
        _isHeaderVisible = false;
      });
    } else if (_scrollController.offset <= 600 && !_isHeaderVisible) {
      setState(() {
        _isHeaderVisible = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int activeIndex = 1;
  final PageController controller = PageController(
    initialPage: 1,
    viewportFraction: 0.97,
  );

  final urlImages = [
    Server.urlGambar("Robotik.jpg"),
    Server.urlGambar("Menggambar.jpg"),
    Server.urlGambar("Mewarnai.jpg"),
  ];

  final deskripsi = [
    "Robotik adalah kegiatan yang membantu anak untuk mengembangkan kreativitas. Dengan robotik, anak dapat membuat robot sesuai dengan imajinasi mereka.",
    "Menggambar adalah kegiatan yang membantu anak untuk mengembangkan kreativitas. Dengan menggambar, anak dapat menggambar dan membuat desain sesuai dengan imajinasi mereka.",
    "Mewarnai adalah kegiatan yang membantu anak untuk mengembangkan kreativitas. Dengan mewarnai, anak dapat mewarnai dan membuat desain sesuai dengan imajinasi mereka."
  ];
  final textTombol = ["Robotik", "Menggambar", "Mewarnai"];

  final judul = ["ROBOTIK", "MENGGAMBAR", "MEWARNAI"];

  Future<void> Pindah() async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1500),
        pageBuilder: (context, animation, secondaryAnimation) => Login(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: CustomColors.greyBackground,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.only(top: 105),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        controller: controller,
                        physics: const PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: urlImages.length,
                        onPageChanged: (index) =>
                            setState(() => activeIndex = index),
                        itemBuilder: (context, index) {
                          double scale = activeIndex == index ? 1 : 0.9;
                          return Transform.scale(
                            scale: scale,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: buildImage(
                                urlImages[index],
                                judul[index],
                                deskripsi[index],
                                textTombol[index],
                                index,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    buildIndicator(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          buildProfileGrid(),
                          const SizedBox(height: 10),
                          buildInfoCard("Kenapa harus TK Al-Alim?", [
                            [
                              "Kurikulum Terpadu",
                              "Lorem ipsum akdbidj shsvtgssLorem ipsum akdbidj shsvtgssLorem ipsum akdbidj shsvtgssLorem ipsum akdbidj shsvtgssLorem ipsum akdbidj shsvtgssLorem ipsum akdbidj shsvtgss",
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
                              Icons.people_outline
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
                              "Melaksanakan pembelajaran aktif, kreatif, efektif, dan inovatif Membimbing dan melatih anak untuk berakhlak mulia Menciptakan suasana belajar yang menyenangkan dan peduli dengan lingkungan sekitar Meningkatkan potensi dari berbagai aspek perkembangan",
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
                    Text(
                      "Masuk untuk mengakses informasi dan layanan TK Al-Alim\n(Untuk Orang Tua)",
                      style:
                          CustomText.TextSfProBold(12, CustomColors.greyText),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: CustomButton.DefaultButton(CustomColors.primary),
                      onPressed: () {
                        Pindah();
                      },
                      child: Text("Masuk",
                          style: CustomText.TextSfProBold(
                              20, CustomColors.whiteColor)),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            curve: Curves.bounceOut,
            top: _isHeaderVisible ? -0 : -150,
            left: 0,
            right: 0,
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              color: CustomColors.whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    Server.urlGambar("logo.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
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
                                style: CustomText.TextSfProBold(
                                    14, CustomColors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        style:
                            CustomButton.miniButton(CustomColors.primarySoft),
                        onPressed: () {
                          Pindah();
                        },
                        child: Text(
                          "Masuk",
                          style: CustomText.TextSfProBold(
                              14, CustomColors.secondary),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(urlImages.length, (index) {
          return GestureDetector(
            onTap: () => animateToSlide(index),
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

  void animateToSlide(int index) => controller.animateToPage(index,
      duration: Duration(milliseconds: 300), curve: Curves.easeInOut);

  Widget buildProfileGrid() => GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1,
        children: [
          profileTile(
              "ic_jumlah_siswa.png", "15+", "Jumlah Siswa", "Anak didik"),
          profileTile("ic_akreditasi.png", "-", "Akreditasi", "Belum Terisi"),
          profileTile("ic_program.png", "3", "Program", "Ekstrakurikuler"),
          profileTile(
              "ic_pengajar.png", "15+", "Pengajar", "Pengajar Kompeten"),
        ],
      );

  Widget profileTile(
          String imgIcon, String hasil, String jumlah, String label) =>
      Card(
        elevation: 1,
        color: CustomColors.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: CustomColors.grey, width: 0.6)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Server.urlGambar(imgIcon), scale: 2),
              SizedBox(height: 10),
              Text(hasil,
                  style: CustomText.TextSfProBold(20, CustomColors.secondary)),
              Text(jumlah,
                  style: CustomText.TextSfProBold(16, CustomColors.blackColor)),
              Text(label,
                  style: CustomText.TextSfProBold(
                      14, CustomColors.blackColor.withOpacity(0.5))),
            ],
          ),
        ),
      );

  Widget buildInfoCard(String title, List<List<dynamic>> items) => Column(
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
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      decoration: BoxDecoration(
                        color: CustomColors.secondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    // Card utama
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          border: Border.all(
                            width: 1,
                            color: CustomColors.grey.withOpacity(0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon centang bulat
                              Container(
                                margin: EdgeInsets.all(2),
                                child: Icon(item[2],
                                    size: 24, color: CustomColors.secondary),
                              ),
                              const SizedBox(width: 15),
                              // Judul dan deskripsi
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item[0],
                                      style: CustomText.TextSfProBold(
                                          14, CustomColors.secondary),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item[1],
                                      style: CustomText.TextSfPro(
                                          12, Colors.grey[700]!),
                                    ),
                                    SizedBox(height: 10)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )))
        ],
      );

  Widget buildVisiMisiCard(String title, List<List<dynamic>> items) => Column(
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
              child: IntrinsicHeight(
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(
                        width: 1,
                        color: CustomColors.grey.withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon centang bulat
                          Container(
                            margin: EdgeInsets.all(2),
                            child: Icon(item[2],
                                size: 24, color: CustomColors.secondary),
                          ),
                          const SizedBox(width: 15),
                          // Judul dan deskripsi
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item[0],
                                  style: CustomText.TextSfProBold(
                                      14, CustomColors.secondary),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item[1],
                                  style: CustomText.TextSfPro(
                                      12, Colors.grey[700]!),
                                ),
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))),
        ],
      );
}

Widget buildImage(String urlImage, String judul, String deskripsi,
    String tombolText, int index) {
  return Container(
    alignment: Alignment.center,
    child: Card(
      color: CustomColors.whiteColor,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    color: CustomColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    deskripsi,
                    style: TextStyle(
                      color: CustomColors.whiteColor,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.grey.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    tombolText,
                    style: TextStyle(color: Colors.white),
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
