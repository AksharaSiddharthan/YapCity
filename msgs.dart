

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  bool showActions = false;
  bool showNewContactPanel = false;
  bool showNewGroupPanel = false;

  final List<Color> gradientColors = [const Color(0xFFA4E7B3), const Color(0xFFA2DDE8)];

  // For New Group Panel
  final TextEditingController groupNameCtrl = TextEditingController();
  final TextEditingController groupSearchCtrl = TextEditingController();

  final List<Map<String, dynamic>> groupContacts = List.generate(
    6,
    (i) => {
      "name": "Contact name ${i + 1}",
      "avatar": "https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg",
      "selected": false,
    },
  );

  // For New Contact Panel
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController mailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    mailCtrl.dispose();
    phoneCtrl.dispose();
    groupNameCtrl.dispose();
    groupSearchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lastMsgStyle = GoogleFonts.inter(
      fontSize: 13,
      color: Colors.black,
      fontWeight: FontWeight.w300,
    );

    final List<Map<String, dynamic>> messages = List.generate(
      6,
      (i) => {
        "name": "Contact name ${i + 1}",
        "lastMsg": "Last Text Sent here",
        "time": "12:00pm",
        "unread": i % 2 == 0 ? 2 : 0,
        "avatar": "https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg",
      },
    );

    // Sort so that contacts with unread notifications are at the top
    final sortedMessages = List<Map<String, dynamic>>.from(messages)
      ..sort((a, b) => (b["unread"] > 0 ? 1 : 0).compareTo(a["unread"] > 0 ? 1 : 0));

    // Filter group contacts by search
    final filteredGroupContacts = groupContacts
        .where((c) => (c["name"] as String)
            .toLowerCase()
            .contains(groupSearchCtrl.text.toLowerCase()))
        .toList();

    // Enable create as soon as at least one contact is selected
    final canCreateGroup = groupContacts.any((c) => c["selected"] == true);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    "Messages",
                    style: GoogleFonts.magra(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Gradient Search Bar, snug left
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Icon(Icons.search, color: Colors.white, size: 26),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4, right: 8),
                            child: TextField(
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                hintText: "Search Contacts",
                                hintStyle: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.85),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Contact List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: sortedMessages.length,
                    itemBuilder: (context, index) {
                      final msg = sortedMessages[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                contactName: msg["name"] as String,
                                avatarUrl: msg["avatar"] as String,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(msg["avatar"] as String),
                                  radius: 20, // Reduced size
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        msg["name"] as String,
                                        style: GoogleFonts.magra(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        msg["lastMsg"] as String,
                                        style: lastMsgStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      msg["time"] as String,
                                      style: lastMsgStyle,
                                    ),
                                    const SizedBox(height: 6),
                                    if ((msg["unread"] as int) > 0)
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: gradientColors,
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          (msg["unread"] as int).toString(),
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            // Gradient Divider
                            Padding(
                              padding: const EdgeInsets.only(left: 3, top: 10, bottom: 10),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: gradientColors,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 80),
              ],
            ),
            // Floating action buttons
            Positioned(
              bottom: 28,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (showActions)
                    _BottomActionButton(
                      icon: Icons.person_add,
                      label: "New Contact",
                      onTap: () {
                        setState(() {
                          showActions = false;
                          showNewContactPanel = true;
                        });
                      },
                      gradientColors: gradientColors,
                    ),
                  if (showActions) const SizedBox(height: 8),
                  if (showActions)
                    _BottomActionButton(
                      icon: Icons.group_add,
                      label: "New Group",
                      onTap: () {
                        setState(() {
                          showActions = false;
                          showNewGroupPanel = true;
                        });
                      },
                      gradientColors: gradientColors,
                    ),
                  GestureDetector(
                    onTap: () => setState(() => showActions = !showActions),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        showActions ? Icons.close : Icons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Slide-up New Contact Panel (unchanged)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              left: 0,
              right: 0,
              bottom: showNewContactPanel ? 0 : -MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height * 0.85,
              child: IgnorePointer(
                ignoring: !showNewContactPanel,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 24),
                          child: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () => setState(() => showNewContactPanel = false),
                                child: Text(
                                  "Close",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Enter the Contact\nInformation Below:",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                            "https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg",
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select Image",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.image_outlined, color: Colors.white, size: 18),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Contact Name", style: GoogleFonts.magra(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 2),
                              TextField(
                                controller: nameCtrl,
                                style: GoogleFonts.inter(fontSize: 14, color: Colors.black87),
                                decoration: const InputDecoration(
                                  hintText: "Enter name",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                              const Divider(),
                              Text("Mail ID:", style: GoogleFonts.magra(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 2),
                              TextField(
                                controller: mailCtrl,
                                style: GoogleFonts.inter(fontSize: 14, color: Colors.black87),
                                decoration: const InputDecoration(
                                  hintText: "Enter mail",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const Divider(),
                              Text("Phone number:", style: GoogleFonts.magra(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 2),
                              TextField(
                                controller: phoneCtrl,
                                style: GoogleFonts.inter(fontSize: 14, color: Colors.black87),
                                decoration: const InputDecoration(
                                  hintText: "Enter phone number",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.person_add_alt_1, color: Color(0xFFA4E7B3)),
                                  onPressed: () {
                                    // You can handle adding the contact here
                                  },
                                ),
                              ),
                              const SizedBox(width:10),
                              Text(
                                "Add Contact",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Slide-up New Group Panel (Figma UI)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              left: 0,
              right: 0,
              bottom: showNewGroupPanel ? 0 : -MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height * 0.95,
              child: IgnorePointer(
                ignoring: !showNewGroupPanel,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 24, left: 24),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () => setState(() => showNewGroupPanel = false),
                                child: Text(
                                  "Close",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Search and group name fields
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    const Icon(Icons.search, color: Colors.black54, size: 22),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        controller: groupSearchCtrl,
                                        onChanged: (_) => setState(() {}),
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Search Contacts",
                                          hintStyle: GoogleFonts.inter(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: TextField(
                                  controller: groupNameCtrl,
                                  textAlign: TextAlign.center,
                                  onChanged: (_) => setState(() {}),
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontWeight: groupNameCtrl.text.trim().isNotEmpty
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Enter Group name",
                                    hintStyle: GoogleFonts.inter(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Contact list with add/check icons
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            itemCount: filteredGroupContacts.length,
                            separatorBuilder: (_, __) => const Divider(color: Colors.white54, height: 16),
                            itemBuilder: (context, index) {
                              final c = filteredGroupContacts[index];
                              final selected = c["selected"] as bool;
                              return Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(c["avatar"] as String),
                                    radius: 18, // Reduced size
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      c["name"] as String,
                                      style: GoogleFonts.magra(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      selected ? Icons.check_circle : Icons.add_circle_outline,
                                      color: selected ? Colors.white : Colors.white,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        c["selected"] = !selected;
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        // Create button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24, right: 24),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Opacity(
                              opacity: canCreateGroup ? 1 : 0.5,
                              child: ElevatedButton(
                                onPressed: canCreateGroup
                                    ? () {
                                        setState(() {
                                          showNewGroupPanel = false;
                                          groupNameCtrl.clear();
                                          groupContacts.forEach((c) => c["selected"] = false);
                                        });
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: Text(
                                  "Create",
                                  style: GoogleFonts.magra(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}

class _BottomActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final List<Color> gradientColors;

  const _BottomActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 44,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.magra(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



