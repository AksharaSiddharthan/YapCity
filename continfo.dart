import 'package:flutter/material.dart';
import 'package:yaptest/main.dart';
import 'grad.dart';


// --- CONTACT INFO SCREEN ---
class ContactInfoScreen extends StatelessWidget {
  final String name, mail, phone, avatarUrl;
  const ContactInfoScreen({super.key, required this.name, required this.mail, required this.phone, required this.avatarUrl});
  @override
  Widget build(BuildContext context) {
    return GradientBg(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 60,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: headingStyle(isGradient: false).copyWith(fontSize: 20)),
                    const Divider(),
                    Text("Mail ID:", style: headingStyle(isGradient: false).copyWith(fontSize: 20)),
                    Text(mail, style: regularStyle(isGradient: false)),
                    const Divider(),
                    Text("Phone number:", style: headingStyle(isGradient: false).copyWith(fontSize: 20)),
                    Text(phone, style: regularStyle(isGradient: false)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
