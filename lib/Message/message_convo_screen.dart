import 'package:flutter/material.dart';

class MessageConvoScreen extends StatefulWidget {
  const MessageConvoScreen({super.key});

  @override
  _MessageConvoScreenState createState() => _MessageConvoScreenState();
}

class _MessageConvoScreenState extends State<MessageConvoScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> messages = []; // List to hold the messages

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text); // Add new message to the list
      });
      _controller.clear(); // Clear the input field after sending
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversation'),
        backgroundColor: const Color(0xFF28435A),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Message list that updates with new messages
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment
                        .centerRight, // Align all messages to the right (for your POV)
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF28435A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Message input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                  color: const Color(0xFF28435A),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
