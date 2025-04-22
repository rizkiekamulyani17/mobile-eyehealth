import 'package:Eye_Health/user_pages/formpendaftaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class HasilDeteksi extends StatelessWidget {
  final XFile gambar_mata;
  final String hasil_deteksi;
  final String accuracy;
  final List<Map<String, dynamic>>? dokter_rekomendasi; // Add doctors data
  final List<Map<String, dynamic>>? obat_rekomendasi; // Add medicines data

  HasilDeteksi({
    super.key,
    required this.gambar_mata,
    required this.hasil_deteksi,
    required this.accuracy,
    this.dokter_rekomendasi,
    this.obat_rekomendasi,
  });

  @override
  Widget build(BuildContext context) {
    switch (hasil_deteksi) {
      case "Normal":
        return Normal(
          img: gambar_mata,
          accuracy: accuracy, // Pass medicine data
        );
      case "Bukan Mata":
        return BukanMata(
          img: gambar_mata,
          accuracy: accuracy,
        );
      case "Mata Katarak" || "Mata Glaucoma" || "Diabetic Retinopathy":
        return Penyakit(
          img: gambar_mata,
          deteksi: hasil_deteksi,
          accuracy: accuracy,
          dokter_rekomendasi: dokter_rekomendasi!, // Pass medicine data
        );
      default:
        return Ringan(
          img: gambar_mata,
          deteksi: hasil_deteksi,
          accuracy: accuracy, // Pass doctor data
          obat_rekomendasi: obat_rekomendasi!, // Pass medicine data
        );
    }
  }
}

class Normal extends StatelessWidget {
  final XFile img;
  final String accuracy;

  Normal({super.key, required this.img, required this.accuracy});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(227, 255, 253, 1),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/svg/warning.svg',
                  color: const Color.fromRGBO(65, 193, 186, 1),
                  width: 25.0,
                  height: 25.0,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Terdeteksi",
                  style: TextStyle(
                    color: Color.fromRGBO(54, 91, 109, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Mata Normal, tetap jaga mata kesehatan mata anda!",
                  style: TextStyle(
                    color: Color.fromRGBO(54, 91, 109, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Image.file(
                  File(img.path), // Use img.path to access the file
                  fit: BoxFit.cover,
                  width: 90,
                  height: 70,
                ),
              ],
            ),
            SizedBox(height: 10),
            // Display accuracy below the image
            Text(
              'Akurasi: $accuracy',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ringan extends StatelessWidget {
  final XFile img;
  final String deteksi;
  final String accuracy;
  final List<Map<String, dynamic>>? obat_rekomendasi; // Nullable

  Ringan({
    super.key,
    required this.img,
    required this.deteksi,
    required this.accuracy,
    this.obat_rekomendasi, // Make it nullable
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(246, 185, 185, 1),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/warning.svg',
                      color: Colors.red,
                      width: 25.0,
                      height: 25.0,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          'Terdeteksi Penyakit Ringan  ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '$deteksi',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Image.file(
                        File(img.path), // Use img.path to access the file
                        fit: BoxFit.cover,
                        width: 90,
                        height: 70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Display accuracy below the image
                Text(
                  'Akurasi: $accuracy',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 30,
          ),
          // Display doctor recommendations (only if dokter_rekomendasi is not null and not empty)
          if (obat_rekomendasi?.isNotEmpty ?? false)
            Container(
              padding: EdgeInsets.all(10),
              color: Color.fromRGBO(220, 252, 231, 1),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/warning.svg',
                        color: Color.fromRGBO(33, 196, 94, 1),
                        width: 25.0,
                        height: 25.0,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Rekomendasi Obat",
                        style: TextStyle(
                          color: Color.fromRGBO(33, 196, 94, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ...obat_rekomendasi!.map((obat) {
                    // Ensure no null value is passed into the Text widget
                    return Column(
                      children: [
                        Text(
                          obat['obat'] ?? 'Obat tidak tersedia',
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Penyakit extends StatelessWidget {
  final XFile img;
  final String deteksi;
  final String accuracy;
  final List<Map<String, dynamic>>? dokter_rekomendasi; // Nullable

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication); // Opens in the browser
    } else {
      throw 'Could not launch $url';
    }
  }

  Penyakit({
    super.key,
    required this.img,
    required this.deteksi,
    required this.accuracy,
    this.dokter_rekomendasi, // Make it nullable
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(246, 185, 185, 1),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/svg/warning.svg',
                      color: Colors.red,
                      width: 25.0,
                      height: 25.0,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          'Perlu Tindakan   ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Hasil deteksi $deteksi',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Image.file(
                        File(img.path), // Use img.path to access the file
                        fit: BoxFit.cover,
                        width: 90,
                        height: 70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Display accuracy below the image
                Text(
                  'Akurasi: $accuracy',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          // Display doctor recommendations (only if dokter_rekomendasi is not null and not empty)
          if (dokter_rekomendasi != null && dokter_rekomendasi!.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(10),
              color: Color.fromRGBO(220, 252, 231, 1),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/warning.svg',
                        color: Color.fromRGBO(33, 196, 94, 1),
                        width: 25.0,
                        height: 25.0,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Rekomendasi Dokter",
                        style: TextStyle(
                          color: Color.fromRGBO(33, 196, 94, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Implementing PageView for doctor recommendations
                  SizedBox(
                    height: 350, // Fixed height for PageView
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: (dokter_rekomendasi!.length / 3).ceil(),
                          itemBuilder: (context, pageIndex) {
                            int startIndex = pageIndex * 3;
                            int endIndex =
                                (startIndex + 3) < dokter_rekomendasi!.length
                                    ? startIndex + 3
                                    : dokter_rekomendasi!.length;
                            List<Map<String, dynamic>> pageDokters =
                                dokter_rekomendasi!
                                    .sublist(startIndex, endIndex);

                            return ListView.builder(
                              itemCount: pageDokters.length,
                              itemBuilder: (context, index) {
                                var dokter = pageDokters[index];
                                return Card(
                                  color: Color.fromRGBO(220, 252, 231, 1),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners for card
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(dokter['profile_img']),
                                      maxRadius: 42,
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(dokter['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                // Launch the URL for doctor's profile
                                                _launchURL(dokter['tentang']);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                              ),
                                              child: Text(
                                                'Profile',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            ElevatedButton(
                                              onPressed: () {
                                                try {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FormPendaftaranPage(
                                                        id_dokter: dokter['id']
                                                            .toString(),
                                                      ),
                                                    ),
                                                  );
                                                } catch (e) {
                                                  print(e);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                              ),
                                              child: Text(
                                                'Daftar',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        // Add a "Next" button to indicate there are more pages
                        Positioned(
                          right: -5,
                          bottom: 120,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class BukanMata extends StatelessWidget {
  final XFile img;
  final String accuracy;

  BukanMata({super.key, required this.img, required this.accuracy});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(247, 242, 195, 1),
            ),
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
                          text: 'Bukan Mata',
                          style: TextStyle(
                            color: Color.fromRGBO(185, 178, 0, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Image.file(
                    File(img.path), // Use img.path to access the file
                    fit: BoxFit.cover,
                    width: 90,
                    height: 70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Display accuracy below the image
          Text(
            'Akurasi: $accuracy',
            style: TextStyle(
              fontSize: 16,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
