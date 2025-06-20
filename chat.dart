
import 'package:flutter/material.dart';

// --- CHAT SCREEN ---
class ChatScreen extends StatefulWidget {
  final String contactName;
  final String avatarUrl;
  const ChatScreen({
    super.key,
    required this.contactName,
    required this.avatarUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> chats = [
    {"me": false, "text": "Content of this msg\nw", "time": "12:00pm"},
    {"me": true, "text": "Content of this msg\nw", "time": "12:00pm"},
    {"me": false, "text": "Content of this msg\nw", "time": "12:00pm"},
    {
      "me": true,
      "text": "Content of this ox\nw wdwed ewd wgr\nrgtgtg rgtg\nrgtgtg\nyhyhtyhytyuji yyhyy",
      "time": "12:00pm"
    },
  ];
  final TextEditingController controller = TextEditingController();

  void _sendMessage() {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        chats.add({"me": true, "text": text, "time": "12:00pm"});
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gradient colors for header and input bar
    const gradientStart = Color(0xFFA2DDE8); // pastel green
    const gradientEnd = Color(0xFFA4E7B3) ;   // pastel blue

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Gradient Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 32, left: 8, right: 16, bottom: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                // Back arrow
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 4),
                // Avatar
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatarUrl),
                  radius: 18,
                ),
                const SizedBox(width: 10),
                // Contact Name
                Text(
                  widget.contactName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final msg = chats[index];
                final isMe = msg["me"] as bool;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        // Sender label and time (above for You, above for Receiver)
                        if (!isMe)
                          Padding(
                            padding: const EdgeInsets.only(left: 6, bottom: 2),
                            child: Text(
                              "Receiver  ${msg["time"]}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                        if (isMe)
                          Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "You",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  msg["time"],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Bubble
                        Container(
                          constraints: const BoxConstraints(maxWidth: 260),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isMe ? gradientEnd : gradientStart,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            msg["text"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                        // Time (for receiver, below bubble right)
                        if (!isMe)
                          Padding(
                            padding: const EdgeInsets.only(top: 2, right: 6),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                msg["time"],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Input bar
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Add button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: gradientStart, size: 28),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                // Text field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontFamily: 'Nunito',
                      ),
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: 'Nunito',
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Send button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: gradientStart, size: 26),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
