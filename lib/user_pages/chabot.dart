import 'package:Eye_Health/services/chatbot.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, dynamic>> _messages =
      []; // List to hold both user and bot messages
  final TextEditingController _controller =
      TextEditingController(); // Controller for the input field

  final ChatbotService _chatbotService =
      ChatbotService(); // Create an instance of ChatbotService

  // Function to handle sending user messages
  void _sendMessage() async {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({
          "message": message,
          "isUser": true, // Mark the message as from the user
        });
      });
      _controller.clear();
      // Call the API to get the bot's reply
      _getBotReply(message);
    }
  }

  // Function to get the bot's reply by calling the ChatbotService
  Future<void> _getBotReply(String userMessage) async {
    try {
      // Use the chatbot service to get the bot's response
      String botReply = await _chatbotService.getBotReply(userMessage);

      setState(() {
        _messages.add({
          "message": botReply, // Set bot's response
          "isUser": false, // Mark the message as from the bot
        });
      });
    } catch (e) {
      // Handle any errors that occur during the API request
      setState(() {
        _messages.add({
          "message": "Error: Unable to connect to the server.",
          "isUser": false,
        });
      });
      print('Error during API request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      endDrawer: SideMenu(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(28),
              ),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  bool isUserMessage = _messages[index]['isUser'];
                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blue[200] : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        _messages[index]['message'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            padding: EdgeInsets.only(top: 10, left: 20),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(28),
            ),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Masukkan Pesan...',
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                  ),
                  padding: EdgeInsets.only(bottom: 10),
                  onPressed:
                      _sendMessage, // Send message when button is pressed
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 1,
        pageIndex: 2,
      ),
    );
  }
}
