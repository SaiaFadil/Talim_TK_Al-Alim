import 'package:talim/UserPages/lupapassword4Pages.dart';
import 'package:talim/src/customFormfield.dart';
import 'package:flutter/material.dart';
import 'package:talim/src/customColor.dart';
import 'package:lottie/lottie.dart';
import 'package:talim/src/customConfirmDialog.dart';

class Lupapassword3 extends StatefulWidget {
  final String email;
  const Lupapassword3({super.key, required this.email});

  @override
  _Lupapassword3State createState() => _Lupapassword3State();
}

class _Lupapassword3State extends State<Lupapassword3> {
  final String _passwordBaruError = '';
  final String _konfirmasiPasswordError = '';
  bool _isPasswordVisible = false;
  bool _isKonfirmasiPasswordVisible = false;
  String _password = '';
  double _strength = 0;
  final bool _isPasswordMatch = true;
  bool _isLoading = false;

  final TextEditingController _passwordBaruController = TextEditingController();
  final TextEditingController _konfirmasiPasswordController =
      TextEditingController();

  bool get _isButtonEnabled =>
      _passwordBaruController.text.isNotEmpty &&
      _konfirmasiPasswordController.text.isNotEmpty &&
      _passwordBaruController.text == _konfirmasiPasswordController.text &&
      _strength >= 2 / 4;

  String _getPasswordStrengthText() {
    if (_strength <= 1 / 4) {
      return 'Lemah';
    } else if (_strength == 2 / 4) {
      return 'Sedang';
    } else if (_strength == 3 / 4) {
      return 'Kuat';
    } else {
      return 'Sangat Kuat';
    }
  }

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  void _checkPassword(String value) {
    setState(() {
      _password = value.trim();

      if (_password.isEmpty) {
        _strength = 0;
      } else if (_password.length < 6) {
        _strength = 1 / 4;
      } else if (_password.length < 8) {
        _strength = 2 / 4;
      } else if (!letterReg.hasMatch(_password) ||
          !numReg.hasMatch(_password)) {
        _strength = 3 / 4;
      } else {
        _strength = 1;
      }
    });
  }

  void _handleNext() async {
    bool confirm = await CustomConfirmDialog.show(
      context: context,
      title: 'Konfirmasi',
      message: 'Apakah password yang anda masukkan sudah benar?',
      confirmText: 'Ya',
      cancelText: 'Tidak',
    );

    if (confirm) {
      setState(() {
        _isLoading = true;
        _SendEmailUser();
      });
    }
  }

  Future<Map<String, dynamic>?> _SendEmailUser() async {
    setState(() {
      _isLoading = true;
    });

    // Simulasi hasil API
    final Map<String, dynamic> result = {
      'status': "success",
      'message': "Password berhasil diubah"
    };

    // TODO: Ganti dengan request API asli
    // final result = await server.ForgotPassword(widget.email, _password);

    print("Result : $result");

    if (result['status'] == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LupaPassword4()),
      );
    } else if (result['status'] == "error") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal ubah password: ${result['message']}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal ubah password: ada kesalahan pengiriman data'),
        ),
      );
    }

    setState(() {
      _isLoading = false; // Sembunyikan loading
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Center(
                      child: Text(
                        'Lupa Password',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontFamily: 'OdorMeanChey',
                        ),
                      ),
                    ),
                    const SizedBox(height: 75),
                    CustomFormField(
                      controller: _passwordBaruController,
                      labelText: 'Password Baru',
                      hintText: 'Masukan Password Baru',
                      obscureText: !_isPasswordVisible,
                      errorText: _passwordBaruError.isNotEmpty
                          ? _passwordBaruError
                          : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      onChanged: (value) => _checkPassword(value),
                    ),
                    const SizedBox(height: 5),
                    // Bar strength password tetap sama
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 5,
                          child: LinearProgressIndicator(
                            value: _strength,
                            backgroundColor: Colors.grey[300],
                            color: _strength <= 1 / 4
                                ? Colors.red
                                : _strength == 2 / 4
                                    ? Colors.yellow
                                    : _strength == 3 / 4
                                        ? Colors.blue
                                        : Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _getPasswordStrengthText(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      controller: _konfirmasiPasswordController,
                      labelText: 'Konfirmasi Password Baru',
                      hintText: 'Masukan Konfirmasi Password Baru',
                      obscureText: !_isKonfirmasiPasswordVisible,
                      errorText: _konfirmasiPasswordError.isNotEmpty
                          ? _konfirmasiPasswordError
                          : null,
                      onChanged: (value) {
                        setState(
                            () {}); // Menyegarkan state agar tombol diperbarui
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isKonfirmasiPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isKonfirmasiPasswordVisible =
                                !_isKonfirmasiPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: _isButtonEnabled ? _handleNext : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isButtonEnabled
                                ? CustomColors.primary
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          child: const Text(
                            'Ganti',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'NotoSanSemiBold',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:
                              Image.asset('assets/images/back.png', width: 24),
                          label: const Text(
                            'Kembali',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'NotoSanSemiBold',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: const BorderSide(color: Colors.black),
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/loading.json',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Mohon Tunggu...',
                      style: TextStyle(
                        fontFamily: 'NotoSanSemiBold',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
