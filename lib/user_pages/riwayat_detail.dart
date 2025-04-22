// riwayat_detail_page.dart
import 'package:Eye_Health/models/histori_pemeriksaan.dart';
import 'package:flutter/material.dart';

class RiwayatDetailPage extends StatelessWidget {
  final RiwayatPemeriksaanModel pemeriksaan;

  RiwayatDetailPage({required this.pemeriksaan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Pemeriksaan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Nama: ${pemeriksaan.nama}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Jenis Kelamin: ${pemeriksaan.jenisKelamin}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Alamat: ${pemeriksaan.alamat}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Nomor HP: ${pemeriksaan.nomorHp}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Pekerjaan: ${pemeriksaan.pekerjaan}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Tanggal Pemeriksaan: ${pemeriksaan.tanggalPemeriksaan}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Riwayat Medis:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Masalah Penglihatan: ${pemeriksaan.masalahPenglihatan}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Menggunakan Kacamata: ${pemeriksaan.menggunakanKacamata}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Riwayat Keluarga: ${pemeriksaan.riwayatKeluarga}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Penjelasan Keluarga: ${pemeriksaan.penjelasanKeluarga}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Penyakit Lain: ${pemeriksaan.penyakitLain}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Penjelasan Penyakit: ${pemeriksaan.penjelasanPenyakit}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Alergi Obat: ${pemeriksaan.alergiObat}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Penjelasan Alergi: ${pemeriksaan.penjelasanAlergi}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Riwayat Keluhan:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Keluhan Utama: ${pemeriksaan.keluhanUtama}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Sejak Kapan: ${pemeriksaan.sejakKapan}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Keluhan Perubahan: ${pemeriksaan.keluhanPerubahan}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Penjelasan Keluhan: ${pemeriksaan.penjelasanKeluhan}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Gejala Tambah: ${pemeriksaan.gejalaTambah}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Penjelasan Gejala: ${pemeriksaan.penjelasanGejala}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
