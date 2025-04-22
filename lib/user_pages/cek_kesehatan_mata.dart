import 'package:Eye_Health/models/hasil.dart';
import 'package:Eye_Health/services/deteksi.dart';
import 'package:Eye_Health/services/session.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';
import '../widgets/btn_unggah.dart';
import '../widgets/btn_deteksi.dart';
import '../widgets/warning.dart';
import '../widgets/hasil_deteksi.dart';

class CekKesehatanMata extends StatefulWidget {
  @override
  _CekKesehatanMataState createState() => _CekKesehatanMataState();
}

class _CekKesehatanMataState extends State<CekKesehatanMata> {
  final SessionService sessionService = SessionService();
  Hasil hasil = Hasil(
    dataDokter: [],
    detectionResult: null,
    message: null,
    obatRekomendasi: [],
    uploadedImage: null,
  );
  final Deteksi deteksiService = Deteksi();

  bool _isHasilVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await sessionService.getToken();
    if (token == null || token.isEmpty) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _updateImage(XFile image) {
    setState(() {
      hasil.gambar_mata = image;
      _isHasilVisible = false;
      _isLoading = false;
    });
  }

  Future<void> _onResult() async {
    if (hasil.gambar_mata != null) {
      setState(() => _isLoading = true);

      try {
        final response =
            await deteksiService.uploadImage(imageFile: hasil.gambar_mata!);

        setState(() {
          hasil.hasil_deteksi = response['detection_result'];
          hasil.akurasi = response['confidence'];
          hasil.dokter_rekomendasi = response['dokter_rekomendasi'] ?? [];
          hasil.obat_rekomendasi = response['obat_rekomendasi'] ?? [];
          _isLoading = false;
          _isHasilVisible = true;
        });
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$e")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please upload an image first.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      endDrawer: SideMenu(),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Center(
            child: Text(
              "Upload dan Deteksi",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(54, 91, 109, 1)),
            ),
          ),
          Warning(),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Unggah Gambar",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      BtnUnggah(onImageSelected: _updateImage),
                      SizedBox(height: 10),
                      Text("Format: PNG, JPG atau JPEG"),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                BtnDeteksi(onDetect: _onResult),
              ],
            ),
          ),
          SizedBox(height: 20),
          if (_isLoading) Center(child: CircularProgressIndicator()),
          if (_isHasilVisible)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HasilDeteksi(
                  gambar_mata: hasil.gambar_mata!,
                  hasil_deteksi: hasil.hasil_deteksi!,
                  accuracy: hasil.akurasi!,
                  dokter_rekomendasi: hasil.dokter_rekomendasi!,
                  obat_rekomendasi: hasil.obat_rekomendasi!,
                ),
              ],
            ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigation(selectedIndex: 0, pageIndex: 10),
    );
  }
}
