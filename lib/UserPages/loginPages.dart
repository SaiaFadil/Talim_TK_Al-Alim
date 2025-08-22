import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:talim/MainMenu/NavbarMenu.dart';
import 'package:talim/UserPages/lupapassword1Pages.dart';
import 'package:talim/src/CustomFormRive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';
import 'package:talim/src/pageTransition.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  late StateMachineController _controller;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<double>? numLook;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    emailFocus.addListener(() {
      isChecking?.value = emailFocus.hasFocus;
    });

    passFocus.addListener(() {
      isHandsUp?.value = passFocus.hasFocus;
    });
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'Login Machine',
    );
    if (controller != null) {
      artboard.addController(controller);
      _controller = controller;

      isChecking = controller.findInput<bool>('isChecking');
      isHandsUp = controller.findInput<bool>('isHandsUp');
      numLook = controller.findInput<double>('numLook');
      trigSuccess = controller.findInput<bool>('trigSuccess');
      trigFail = controller.findInput<bool>('trigFail');
    }
  }

  void login() {
    if (emailCtrl.text == "contoh@gmail.com" && passCtrl.text == "p") {
      trigSuccess?.change(true);
      Navigator.pushReplacement(
          context, SmoothPageTransition(page: NavbarMenu()));
    } else {
      trigFail?.change(true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau password salah!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondary,
      body: SafeArea(
        child: Column(
          children: [
            // === FORM LOGIN DALAM CARD YANG SCROLLABLE ===
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: CustomColors.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 100,
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: RiveAnimation.asset(
                                  'assets/rive/animated_login_character.riv',
                                  fit: BoxFit.cover,
                                  onInit: _onRiveInit,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // === JUDUL DAN SELAMAT DATANG ===
                            Text(
                              "Selamat Datang",
                              style: GoogleFonts.fredoka(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.secondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Yuk masuk ke akunmu!",
                              style: GoogleFonts.fredoka(
                                  fontSize: 16, color: CustomColors.greyText),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 24),

                            // === EMAIL FIELD ===
                            CustomFormRive(
                              controller: emailCtrl,
                              focusNode: emailFocus,
                              label: "Email",
                              hint: "namaemail@gmail.com",
                              icon: Icons.email,
                              onChanged: (val) {
                                numLook?.change(val.length.toDouble());
                              },
                            ),

                            const SizedBox(height: 16),

                            // === PASSWORD FIELD DENGAN TOGGLE ===
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CustomFormRive(
                                  controller: passCtrl,
                                  focusNode: passFocus,
                                  label: "Password",
                                  hint: "Password",
                                  obscure: !isPasswordVisible,
                                  icon: Icons.lock,
                                ),
                                IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: CustomColors.secondary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // === LUPA PASSWORD ===
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      SmoothPageTransition(
                                          page: Lupapassword1()));
                                },
                                child: Text(
                                  "Lupa Password?",
                                  style:
                                      TextStyle(color: CustomColors.greyText),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // === TOMBOL LOGIN ===
                            ElevatedButton(
                                onPressed: login,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 64, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  backgroundColor: CustomColors.secondary,
                                ),
                                child: Text("Masuk",
                                    style: CustomText.TextSfProBold(
                                      18,
                                      CustomColors.whiteColor,
                                    )))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
