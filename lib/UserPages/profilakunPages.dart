import 'dart:convert';
import 'package:talim/src/pageTransition.dart';
import 'package:talim/UserPages/loginPages.dart';
import 'package:talim/src/customFormfield.dart';
import 'package:flutter/material.dart';
import 'package:talim/src/topnav.dart';
import 'package:talim/src/customColor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:talim/src/customDropdown.dart';
import 'package:talim/src/customConfirmDialog.dart';

import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfilAkunPage extends StatefulWidget {
  const ProfilAkunPage({super.key});

  @override
  State<ProfilAkunPage> createState() => _ProfilAkunPageState();
}

class _ProfilAkunPageState extends State<ProfilAkunPage> {
  bool _isEditing = false;
  bool _isLoading = false;
  String email = "";
  String nama_lengkap = "";
  String nik = "";
  String alamat = "";
  String no_hp = "";
  String foto = "";
  int jumlah_gh = 0;

  final ImagePicker _picker = ImagePicker();
  dynamic _profileImage;

  String ImageSaatIni = "";
  // Definisi controller untuk setiap field
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController jumlahGHController = TextEditingController();

  String jenis_kelamin = "laki-laki";
  final List<String> _jenisKelaminItems = ['laki-laki', 'perempuan'];

  @override
  void dispose() {
    // Bersihkan controller untuk menghindari kebocoran memori
    namaLengkapController.dispose();
    nikController.dispose();
    noHpController.dispose();
    alamatController.dispose();
    jumlahGHController.dispose();
    super.dispose();
  }

//Awal backend

  Future<void> showProfil() async {
    // Frontend only: skip panggilan server, gunakan nilai default/dummy
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _isLoading = false;
    });
  }

// Fungsi untuk mendekode JWT
  static Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Token tidak valid');
    }

    final payload = _decodeBase64(parts[1]);
    return json.decode(payload);
  }

  static String _decodeBase64(String str) {
    String normalized = base64Url.normalize(str);
    return utf8.decode(base64Url.decode(normalized));
  }

  static String _encodeBase64(String str) {
    // Extract the file name without the extension
    // Split the file path to get the file name and extension

    List<String> nameParts = str.split('.');

    // Separate the base name and the extension
    String baseName = nameParts[0];
    String extension = nameParts.length > 1 ? nameParts.last : "";

    // Encode the base name in Base64
    String encodedBaseName = base64Url.encode(utf8.encode(baseName));

    // Limit the encoded result to a maximum of 50 characters
    String truncatedEncodedBaseName = encodedBaseName.length > 30
        ? encodedBaseName.substring(0, 30)
        : encodedBaseName;

    // Combine the encoded base name with the original extension
    return extension.isNotEmpty
        ? "$truncatedEncodedBaseName.$extension"
        : truncatedEncodedBaseName;
  }

  // late http.MultipartRequest request; // di-nonaktifkan (frontend only)
  //AKHIR BACKEND

  // Definisi error untuk setiap field
  String _namaLengkapError = '';
  String _nikError = '';
  String _jenisKelaminError = '';
  String _noHpError = '';
  String _alamatError = '';
  String _jumlahGHError = '';

  @override
  void initState() {
    super.initState();
    // Tambahkan listeners untuk setiap controller

    namaLengkapController.addListener(() => _clearError('namaLengkap'));
    nikController.addListener(() => _clearError('nik'));
    noHpController.addListener(() => _clearError('noHp'));
    alamatController.addListener(() => _clearError('alamat'));
    jumlahGHController.addListener(() => _clearError('jumlahGH'));
    showProfil();
  }

  void _clearError(String field) {
    setState(() {
      switch (field) {
        case 'namaLengkap':
          _namaLengkapError = '';
        case 'nik':
          _nikError = '';
        case 'jenisKelamin':
          _jenisKelaminError = '';
        case 'noHp':
          _noHpError = '';
        case 'alamat':
          _alamatError = '';
        case 'jumlahGH':
          _jumlahGHError = '';
      }
    });
  }

  void _validateInputs() async {
    setState(() {
      // Validasi NIK
      if (nikController.text.isEmpty) {
        _nikError = 'NIK tidak boleh kosong';
      } else if (nikController.text.length != 16) {
        _nikError = 'NIK harus 16 digit';
      } else {
        _nikError = '';
      }

      // Validasi No HP
      if (noHpController.text.isEmpty) {
        _noHpError = 'Nomor HP tidak boleh kosong';
      } else if (!noHpController.text.startsWith('08')) {
        _noHpError = 'Nomor HP Tidak Valid';
      } else if (noHpController.text.length > 13) {
        _noHpError = 'Nomor HP maksimal 13 digit';
      } else {
        _noHpError = '';
      }

      // Validasi lainnya
      _namaLengkapError = namaLengkapController.text.isEmpty
          ? 'Nama lengkap tidak boleh kosong'
          : '';
      _jenisKelaminError =
          jenis_kelamin.isEmpty ? 'Jenis kelamin tidak boleh kosong' : '';
      _alamatError =
          alamatController.text.isEmpty ? 'Alamat tidak boleh kosong' : '';
      _jumlahGHError =
          jumlahGHController.text.isEmpty ? 'Jumlah GH tidak boleh kosong' : '';
    });

    if (_namaLengkapError.isEmpty &&
        _nikError.isEmpty &&
        _jenisKelaminError.isEmpty &&
        _noHpError.isEmpty &&
        _alamatError.isEmpty &&
        _jumlahGHError.isEmpty) {
      // Menampilkan CustomConfirmDialog
      bool konfirmasi = await CustomConfirmDialog.show(
        context: context,
        title: 'Konfirmasi',
        message: 'Apakah Anda yakin ingin menyimpan perubahan data?',
        confirmText: 'Simpan',
        cancelText: 'Batal',
      );

      if (konfirmasi && mounted) {
        setState(() {
          print("Konfirmasi : $konfirmasi");
        });
      }
    }
  }

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
        ImageSaatIni = _encodeBase64(pickedFile.name);
        print("GAMBAR : $ImageSaatIni");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Topnav(
          title: 'Akun',
          showBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                          child: _profileImage != null
                              ? FutureBuilder<Uint8List>(
                                  future: _profileImage!.readAsBytes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Image.memory(
                                        snapshot.data!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                )
                              : foto == ""
                                  ? Image.asset(
                                      'assets/images/logo.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(foto)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _isEditing ? getImage : null,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: CustomColors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomFormField(
                controller: namaLengkapController,
                labelText: 'Nama Lengkap',
                hintText: 'Masukan Nama Lengkap',
                errorText:
                    _namaLengkapError.isNotEmpty ? _namaLengkapError : null,
                enabled: _isEditing,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChanged: (value) {
                  setState(() {
                    _namaLengkapError = '';
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: nikController,
                labelText: 'NIK',
                hintText: 'Masukan NIK',
                errorText: _nikError.isNotEmpty ? _nikError : null,
                enabled: _isEditing,
                maxLength: 16,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'[A-Za-z]')),
                  LengthLimitingTextInputFormatter(16),
                ],
                onChanged: (value) {
                  if (value.contains(RegExp(r'[A-Za-z]'))) {
                    nikController.text =
                        value.replaceAll(RegExp(r'[A-Za-z]'), '');
                  }
                  setState(() {
                    _nikError = '';
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                labelText: 'Jenis Kelamin',
                hintText: 'Pilih Jenis Kelamin',
                value: jenis_kelamin,
                items: _jenisKelaminItems,
                errorText:
                    _jenisKelaminError.isNotEmpty ? _jenisKelaminError : null,
                enabled: _isEditing,
                onChanged: (String? newValue) {
                  setState(() {
                    jenis_kelamin = newValue ?? jenis_kelamin;
                    _jenisKelaminError = '';
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: noHpController,
                labelText: 'No HP',
                hintText: 'Masukan No HP',
                errorText: _noHpError.isNotEmpty ? _noHpError : null,
                enabled: _isEditing,
                maxLength: 13,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'[A-Za-z]')),
                  LengthLimitingTextInputFormatter(13),
                ],
                onChanged: (value) {
                  if (value.contains(RegExp(r'[A-Za-z]'))) {
                    noHpController.text =
                        value.replaceAll(RegExp(r'[A-Za-z]'), '');
                  }
                  setState(() {
                    _noHpError = '';
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: alamatController,
                labelText: 'Alamat Lengkap',
                hintText: 'Masukan Alamat Lengkap',
                errorText: _alamatError.isNotEmpty ? _alamatError : null,
                enabled: _isEditing,
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _alamatError = '';
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: jumlahGHController,
                labelText: 'Jumlah GH',
                hintText: 'Masukan Jumlah GH',
                errorText: _jumlahGHError.isNotEmpty ? _jumlahGHError : null,
                enabled: false,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'[A-Za-z]')),
                ],
                onChanged: (value) {
                  if (value.contains(RegExp(r'[A-Za-z]'))) {
                    jumlahGHController.text =
                        value.replaceAll(RegExp(r'[A-Za-z]'), '');
                  }
                  setState(() {
                    _jumlahGHError = '';
                  });
                },
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                      child: Text(
                        _isEditing ? 'Selesai' : 'Edit',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'NotoSanSemiBold',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      onPressed: _isEditing ? _validateInputs : null,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'NotoSanSemiBold',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
