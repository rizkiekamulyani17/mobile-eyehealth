import 'package:flutter/material.dart';

class MessageDetailPage extends StatelessWidget {
  final String senderName;
  final String message;

  const MessageDetailPage({
    super.key,
    required this.senderName,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sender: $senderName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Message: $message',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
