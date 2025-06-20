import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaptest/msgs.dart';

// login page for the app

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController =
      TextEditingController(text: "Akshara Siddharthan");
  final TextEditingController emailController =
      TextEditingController(text: "akshara@gmail.com");
  final TextEditingController phoneController =
      TextEditingController(text: "1234567890");

  @override
  Widget build(BuildContext context) {
    final Color gradientTop = const Color(0xFFB3E5FC); // light blue
    final Color gradientBottom = const Color(0xFFA8E6CF); // light green

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientTop, gradientBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Yap logo
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      // child: Text(
                      //   "Yap",
                      //   style: GoogleFonts.baloo2(
                      //     color: Colors.white,
                      //     fontSize: 36,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Login heading (centered)
                  Text(
                    "Login",
                    style: GoogleFonts.baloo2(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Card with editable fields
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Contact Name
                        Text(
                          "Contact Name",
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 2),
                        TextField(
                          controller: nameController,
                          style: GoogleFonts.nunito(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Divider(thickness: 1, color: Colors.grey[300]),
                        const SizedBox(height: 8),
                        // Mail ID
                        Text(
                          "Mail ID:",
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 2),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.nunito(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Divider(thickness: 1, color: Colors.grey[300]),
                        const SizedBox(height: 8),
                        // Phone number
                        Text(
                          "Phone number:",
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 2),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          style: GoogleFonts.nunito(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Button
                  SizedBox(
                    width: 200,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: gradientTop,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MessagesScreen()),
                        );
                      },
                      child: Text(
                        "Set to yap!",
                        style: GoogleFonts.nunito(
                          color: gradientTop,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

