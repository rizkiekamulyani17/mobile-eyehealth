import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Warning extends StatelessWidget {
  const Warning({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(247, 242, 195, 1),
      ),
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/svg/warning.svg',
            color: const Color.fromRGBO(185, 178, 0, 1),
            width: 25.0,
            height: 25.0,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Perhatian! ',
                    style: TextStyle(
                      color: Color.fromRGBO(185, 178, 0, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Sistem deteksi ini menggunakan teknologi kecerdasan buatan dengan nilai akurasi 90% yang artinya hasil yang ditampilkan masih mempunyai kesalahan prediksi. kami menyarankan anda untuk melakukan deteksi 3-5 kali dengan sudut foto yang berbeda. ',
                    style: TextStyle(
                      color: Color.fromRGBO(185, 178, 0, 1),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
