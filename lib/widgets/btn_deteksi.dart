import 'package:flutter/material.dart';

class BtnDeteksi extends StatelessWidget {
  final VoidCallback onDetect;

  const BtnDeteksi({
    Key? key,
    required this.onDetect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // Set height for the button
      decoration: BoxDecoration(
        color: const Color.fromRGBO(33, 150, 243, 1), // Blue button color
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: onDetect, // Call the passed function when clicked
        child: const Text(
          "Deteksi",
          style: TextStyle(
            color: Colors.white, // Text color
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
