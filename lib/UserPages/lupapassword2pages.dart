import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:talim/src/customColor.dart';
import 'package:talim/UserPages/lupapassword3Pages.dart';

class LupaPassword2 extends StatefulWidget {
  final String email;
  const LupaPassword2({super.key, required this.email});

  @override
  State<LupaPassword2> createState() => _LupaPassword2State();
}

class _LupaPassword2State extends State<LupaPassword2> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  String _otpError = '';
  bool _isLoading = false;
  int _timerSeconds = 60;
  Timer? _timer;
  bool _isTimerRunning = true;
  String _generatedOTP = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
    _sendOTP(); // Kirim OTP pertama kali
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// Timer untuk countdown kirim ulang OTP
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        setState(() => _isTimerRunning = false);
        _timer?.cancel();
      }
    });
  }

  /// Generate OTP lokal untuk testing
  String _generateOTP({int length = 5}) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10).toString()).join();
  }

  /// Kirim OTP (lokal)
  void _sendOTP() {
    setState(() {
      _timerSeconds = 60;
      _isTimerRunning = true;
      _generatedOTP = _generateOTP();
    });
    _startTimer();

    // Untuk testing, OTP dicetak di console
    debugPrint("OTP Testing untuk ${widget.email}: $_generatedOTP");
  }

  /// Validasi OTP
  void _validateOTP() {
    if (pinController.text == _generatedOTP) {
      setState(() => _otpError = '');
      setState(() => _isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Lupapassword3(email: widget.email),
          ),
        );
      });
    } else {
      setState(() => _otpError = 'Kode OTP salah atau tidak valid.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: CustomColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
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
                            const SizedBox(height: 30),
                            Center(
                              child: Image.asset(
                                'assets/images/forgotpassword.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width * 0.6,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Center(
                              child: Text(
                                'Masukkan Kode OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'NotoSanSemiBold',
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Pinput(
                                length: 5,
                                controller: pinController,
                                focusNode: focusNode,
                                defaultPinTheme: defaultPinTheme,
                                separatorBuilder: (index) =>
                                    const SizedBox(width: 8),
                                onCompleted: (_) =>
                                    setState(() => _otpError = ''),
                              ),
                            ),
                            if (_otpError.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _otpError,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Waktu tersisa: ${_timerSeconds}s',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                TextButton(
                                  onPressed: _isTimerRunning ? null : _sendOTP,
                                  child: Text(
                                    'Kirim ulang',
                                    style: TextStyle(
                                      color: _isTimerRunning
                                          ? Colors.grey
                                          : CustomColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                  onPressed: _validateOTP,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                  ),
                                  child: const Text(
                                    'Lanjutkan',
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
                                  onPressed: () => Navigator.pop(context),
                                  icon: Image.asset(
                                    'assets/images/back.png',
                                    width: 24,
                                  ),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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
