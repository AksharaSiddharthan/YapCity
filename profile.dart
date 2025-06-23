import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isEditing = false;
  late TextEditingController nameCtrl;
  late TextEditingController mailCtrl;
  late TextEditingController phoneCtrl;

  final String imageUrl =
      "https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg";

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: "Akshara Siddharthan");
    mailCtrl = TextEditingController(text: "akshara@gmail.com");
    phoneCtrl = TextEditingController(text: "1234567890");
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    mailCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gradientColors = [Color(0xFFA2DDE8), Color(0xFFA4E7B3)];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                      padding: const EdgeInsets.all(2.0),
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 200),
                    GestureDetector(
                      onTap: () {
                        setState(() => isEditing = !isEditing);
                      },
                      child: Text(
                        isEditing ? "Save" : "Edit",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "My Profile",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              if (isEditing)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextButton.icon(
                    onPressed: () {
                      // Add your image picker logic here if needed in the future
                    },
                    icon: const Icon(Icons.image_outlined, color: Colors.white),
                    label: Text(
                      "Change Profile Image",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                margin: const EdgeInsets.symmetric(horizontal: 24),
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
                      style: GoogleFonts.magra(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    isEditing
                        ? TextField(
                            controller: nameCtrl,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 10),
                            child: Text(
                              nameCtrl.text,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                    // Gradient Divider
                    Container(
                      height: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Mail ID
                    Text(
                      "Mail ID:",
                      style: GoogleFonts.magra(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    isEditing
                        ? TextField(
                            controller: mailCtrl,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 10),
                            child: Text(
                              mailCtrl.text,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.grey[600],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                    // Gradient Divider
                    Container(
                      height: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Phone number
                    Text(
                      "Phone number:",
                      style: GoogleFonts.magra(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    isEditing
                        ? TextField(
                            controller: phoneCtrl,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            keyboardType: TextInputType.phone,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 10),
                            child: Text(
                              phoneCtrl.text,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
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
