import 'package:Eye_Health/services/sentimen.dart';
import 'package:Eye_Health/widgets/bottom_navigation.dart';
import 'package:Eye_Health/widgets/developer.dart';
import 'package:Eye_Health/widgets/header.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _komentarController = TextEditingController();
  final SentimentService _sentimentService = SentimentService();

  // Handles form submission and API call
  Future<void> _submitKomentar(BuildContext context) async {
    final userNama = _namaController.text.trim();
    final userKomentar = _komentarController.text.trim();

    if (userNama.isEmpty || userKomentar.isEmpty) {
      _showSnackbar(
          context, 'Nama dan komentar tidak boleh kosong.', Colors.red);
      return;
    }

    try {
      String response =
          await _sentimentService.postKomentar(userNama, userKomentar);

      // Show success message after successful submission
      _showSnackbar(
          context, 'Komentar berhasil dikirim! Terima kasih.', Colors.green);

      // Clear the input fields after submission
      _namaController.clear();
      _komentarController.clear();
    } catch (e) {
      _showSnackbar(context, 'Terjadi kesalahan. Coba lagi nanti.', Colors.red);
    }
  }

  // Utility to show snackbars
  void _showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      endDrawer: SideMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            _buildCenteredTitle(
              "MATA SEHAT, MASA DEPAN CERAH",
              fontSize: 23,
              color: const Color.fromRGBO(51, 145, 255, 1),
            ),
            const SizedBox(height: 10),
            _buildDescription(
              "Menuju Teknologi yang lebih baik di masa depan",
              color: const Color.fromRGBO(54, 91, 109, 1),
            ),
            Image.asset("assets/img/about.png"),
            const SizedBox(height: 10),
            _buildCenteredTitle(
              "Mengoptimalkan Kesejahteraan dengan Inovasi Deteksi Kesehatan Mata",
              fontSize: 18,
              color: const Color.fromRGBO(65, 183, 186, 1),
            ),
            const SizedBox(height: 10),
            _buildDescription(
              "Penyakit mata, seperti katarak, glaukoma, dan retinopati diabetik, merupakan penyebab utama gangguan penglihatan dan kebutaan di dunia, dengan lebih dari 2,2 miliar orang terdampak. Keterlambatan diagnosis, kurangnya akses ke tenaga medis spesialis, serta rendahnya kesadaran masyarakat memperparah situasi ini, terutama di daerah terpencil. Di era digital, teknologi berbasis kecerdasan buatan dan telemedicine menjadi solusi efektif untuk deteksi dini penyakit mata, sehingga dapat menurunkan angka kebutaan dan meningkatkan kualitas hidup masyarakat.",
              color: const Color.fromRGBO(54, 91, 109, 1),
            ),
            const SizedBox(height: 40),
            _buildCenteredTitle(
              "Development",
              fontSize: 23,
              color: const Color.fromRGBO(51, 145, 255, 1),
            ),
            const SizedBox(height: 30),
            Developer(),
            const SizedBox(height: 40),
            Text(
              "Tambahkan Komentar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            _buildInputField(_namaController, "Nama"),
            SizedBox(
              height: 10,
            ),
            _buildInputField(_komentarController, "Komentar"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _submitKomentar(context),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: const TextStyle(fontSize: 16),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Kirim",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
        selectedIndex: 0,
        pageIndex: 10,
      ),
    );
  }

  // Utility widget to build centered title text
  Widget _buildCenteredTitle(String text,
      {required double fontSize, required Color color}) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Utility widget to build descriptions
  Widget _buildDescription(String text, {required Color color}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Utility widget to build input fields
  Widget _buildInputField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: label,
        hintStyle: const TextStyle(fontSize: 18),
      ),
    );
  }
}
