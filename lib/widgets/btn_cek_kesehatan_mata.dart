import 'package:flutter/material.dart';
import '../user_pages/cek_kesehatan_mata.dart';

class btn_cek_kesehatan_mata extends StatelessWidget {
  const btn_cek_kesehatan_mata({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/deteksi',
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      label: const Text(
        "Cek Kesehatan Mata",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      icon: const Icon(
        Icons.add,
        color: Colors.white,
        size: 25,
        weight: 800,
      ),
    );
  }
}
