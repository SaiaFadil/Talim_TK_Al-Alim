import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';

class DetailProfil extends StatefulWidget {
  const DetailProfil({super.key});

  @override
  State<DetailProfil> createState() => _DetailProfilState();
}

class _DetailProfilState extends State<DetailProfil> {
  final Map<String, dynamic> profilData = {
    "namaLengkap": "Fatimatul Munawaroh",
    "tanggalLahir": "1987-03-07",
    "telepon": "81234567890",
    "kodeNegara": "+62",
    "jenisKelamin": "Perempuan",
    "alamat": "Lowokwaru, Malang",
    "avatar": null
  };

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  String _kodeNegara = "+62";
  String _jenisKelamin = "Perempuan";

  @override
  void initState() {
    super.initState();
    _namaController.text = profilData["namaLengkap"] ?? "";
    _tanggalController.text = profilData["tanggalLahir"] != null
        ? DateFormat("dd/MM/yyyy")
            .format(DateTime.parse(profilData["tanggalLahir"]))
        : "";
    _teleponController.text = profilData["telepon"] ?? "";
    _kodeNegara = profilData["kodeNegara"] ?? "+62";
    _jenisKelamin = profilData["jenisKelamin"] ?? "Perempuan";
    _alamatController.text = profilData["alamat"] ?? "";
  }

  Future<void> _pickDate() async {
    DateTime initialDate =
        DateTime.tryParse(profilData["tanggalLahir"] ?? "") ?? DateTime(2000);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text = DateFormat("dd/MM/yyyy").format(picked);
      });
    }
  }

  void _simpanData() {
    if (_namaController.text.trim().isEmpty) {
      _showError("Nama lengkap tidak boleh kosong");
      return;
    }
    if (_tanggalController.text.trim().isEmpty) {
      _showError("Tanggal lahir tidak boleh kosong");
      return;
    }
    if (_teleponController.text.trim().isEmpty) {
      _showError("Nomor telepon tidak boleh kosong");
      return;
    }
    if (_alamatController.text.trim().isEmpty) {
      _showError("Alamat tidak boleh kosong");
      return;
    }

    print("Data disimpan:");
    print("Nama: ${_namaController.text}");
    print("Tanggal Lahir: ${_tanggalController.text}");
    print("Telepon: $_kodeNegara ${_teleponController.text}");
    print("Jenis Kelamin: $_jenisKelamin");
    print("Alamat: ${_alamatController.text}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Data berhasil disimpan",
            style: CustomText.TextSfPro(14, CustomColors.whiteColor)),
        backgroundColor: CustomColors.green,
      ),
    );
  }

  void _showError(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan,
            style: CustomText.TextSfPro(14, CustomColors.whiteColor)),
        backgroundColor: CustomColors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.whiteColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: CustomColors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Profil",
          style: CustomText.TextSfProBold(18, CustomColors.blackColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            // Avatar & Nama
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: (profilData["avatar"] == null ||
                          profilData["avatar"].toString().isEmpty ||
                          profilData["avatar"].toString() == "null")
                      ? const AssetImage('assets/images/logo.png')
                          as ImageProvider
                      : NetworkImage(profilData["avatar"]),
                ),
                const SizedBox(height: 8),
                Text(
                  profilData["namaLengkap"] ?? "",
                  style: CustomText.TextSfProBold(16, CustomColors.blackColor),
                )
              ],
            ),
            const SizedBox(height: 20),

            // Card Form
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: CustomColors.greyBackground2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama Lengkap (Sesuai KTP)",
                      style: CustomText.TextSfProBold(
                          16, CustomColors.blackColor)),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _namaController,
                    style: CustomText.TextSfPro(14, CustomColors.blackColor),
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 12),
                  Text("Tanggal Lahir",
                      style: CustomText.TextSfProBold(
                          16, CustomColors.blackColor)),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _tanggalController,
                    readOnly: true,
                    style: CustomText.TextSfPro(14, CustomColors.blackColor),
                    decoration: _inputDecoration().copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today,
                            color: CustomColors.primary),
                        onPressed: _pickDate,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text("Nomor Telepon",
                      style: CustomText.TextSfProBold(
                          16, CustomColors.blackColor)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: CustomColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButton<String>(
                          value: _kodeNegara,
                          underline: const SizedBox(),
                          iconEnabledColor: CustomColors.whiteColor,
                          dropdownColor: CustomColors.secondary,
                          style:
                              CustomText.TextSfPro(14, CustomColors.whiteColor),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _kodeNegara = value;
                              });
                            }
                          },
                          items: [
                            "+62",
                          ]
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e,
                                      style: CustomText.TextSfPro(
                                          14, CustomColors.whiteColor))))
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _teleponController,
                          keyboardType: TextInputType.phone,
                          style:
                              CustomText.TextSfPro(14, CustomColors.blackColor),
                          decoration: _inputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text("Jenis Kelamin",
                      style: CustomText.TextSfProBold(
                          16, CustomColors.blackColor)),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Perempuan",
                        activeColor: CustomColors.primary,
                        groupValue: _jenisKelamin,
                        onChanged: (val) {
                          setState(() {
                            _jenisKelamin = val!;
                          });
                        },
                      ),
                      Text("Perempuan",
                          style: CustomText.TextSfPro(
                              14, CustomColors.blackColor)),
                      const SizedBox(width: 10),
                      Radio<String>(
                        value: "Laki-Laki",
                        activeColor: CustomColors.primary,
                        groupValue: _jenisKelamin,
                        onChanged: (val) {
                          setState(() {
                            _jenisKelamin = val!;
                          });
                        },
                      ),
                      Text("Laki-Laki",
                          style: CustomText.TextSfPro(
                              14, CustomColors.blackColor)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text("Alamat Tempat Tinggal",
                      style: CustomText.TextSfProBold(
                          16, CustomColors.blackColor)),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: _alamatController.text.isNotEmpty
                        ? _alamatController.text
                        : null,
                    style: CustomText.TextSfPro(14, CustomColors.blackColor),
                    decoration: _inputDecoration(),
                    items: [
                      "Lowokwaru, Malang",
                      "Blimbing, Malang",
                      "Klojen, Malang"
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _alamatController.text = val;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _simpanData,
                child: Text(
                  "Selesai",
                  style: CustomText.TextSfProBold(16, CustomColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: CustomColors.greyBackground,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.grey.withAlpha(10)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}
