// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'grad.dart';
import 'login.dart';
import 'msgs.dart';
import 'chat.dart';
import 'continfo.dart';




void main() => runApp(const YapApp());

const gradientColors = [Color(0xFFA2DDE8),Color(0xFFA4E7B3),];

TextStyle headingStyle({required bool isGradient}) => GoogleFonts.magra(
      fontSize: 14,
      color: isGradient ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
    );
TextStyle buttonStyle() => GoogleFonts.magra(
      fontSize: 10,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
TextStyle regularStyle({required bool isGradient}) => GoogleFonts.inter(
      fontSize: 8,
      color: isGradient ? Colors.white : Colors.black,
    );
TextStyle smallStyle({required bool isGradient}) => GoogleFonts.inter(
      fontSize: 6,
      color: isGradient ? Colors.white : Colors.black,
    );

class YapApp extends StatelessWidget {
  const YapApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yap',
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
    );
  }
}



// --- START SCREEN ---
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientBg(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Yap",
                style: GoogleFonts.magra(
                  fontSize: 100,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "A better way to chat.\nFast, smooth, and made for you.",
                textAlign: TextAlign.center,
                style: regularStyle(isGradient: true),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: gradientColors[0],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: Text("Get Started", style: buttonStyle()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

