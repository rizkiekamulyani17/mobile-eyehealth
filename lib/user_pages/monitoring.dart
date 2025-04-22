import 'package:Eye_Health/models/monitoring.dart';
import 'package:Eye_Health/services/monitoring.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonitoringPage extends StatefulWidget {
  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  final MonitoringService _service = MonitoringService();
  List<Pasien> _patients = [];
  bool _loading = true;
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Fetch data based on the selected date
  Future<void> _fetchData({String? search, String? date}) async {
    setState(() {
      _loading = true;
    });

    final patients =
        await _service.fetchMonitoringData(search: search, date: date);
    setState(() {
      _patients = patients;
      _loading = false;
    });
  }

  // Show the date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
      // Fetch data with the selected date
      _fetchData(date: _selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitoring'),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () => _selectDate(context), // Open the date picker
          ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _patients.isEmpty
              ? Center(child: Text('No data found'))
              : Column(
                  children: [
                    if (_selectedDate != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Selected Date: $_selectedDate',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _patients.length,
                        itemBuilder: (context, index) {
                          final patient = _patients[index];
                          return ListTile(
                            title: Text(patient.nama),
                            subtitle: Text(
                                'Tanggal Pemeriksaan: ${patient.tanggalPemeriksaan}'),
                            onTap: () {
                              _showPatientDetails(context, patient);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  // Show a dialog or screen with patient details
  void _showPatientDetails(BuildContext context, Pasien patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(patient.nama),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tanggal Lahir: ${patient.tanggalLahir}'),
            Text('Jenis Kelamin: ${patient.jenisKelamin}'),
            Text('Alamat: ${patient.alamat}'),
            Text('Nomor HP: ${patient.nomorHp}'),
            Text('Pekerjaan: ${patient.pekerjaan}'),
            Text('Tanggal Pemeriksaan: ${patient.tanggalPemeriksaan}'),
            if (patient.riwayatMedis != null) ...[
              Divider(),
              Text('Riwayat Medis:'),
              Text(
                  'Masalah Penglihatan: ${patient.riwayatMedis?.masalahPenglihatan ?? 'N/A'}'),
              Text(
                  'Menggunakan Kacamata: ${patient.riwayatMedis?.menggunakanKacamata ?? 'N/A'}'),
              Text(
                  'Riwayat Keluarga: ${patient.riwayatMedis?.riwayatKeluarga ?? 'N/A'}'),
              Text(
                  'Penyakit Lain: ${patient.riwayatMedis?.penyakitLain ?? 'N/A'}'),
            ],
            if (patient.riwayatKeluhan != null) ...[
              Divider(),
              Text('Riwayat Keluhan:'),
              Text(
                  'Keluhan Utama: ${patient.riwayatKeluhan?.keluhanUtama ?? 'N/A'}'),
              Text(
                  'Sejak Kapan: ${patient.riwayatKeluhan?.sejakKapan ?? 'N/A'}'),
              Text(
                  'Keluhan Perubahan: ${patient.riwayatKeluhan?.keluhanPerubahan ?? 'N/A'}'),
              Text(
                  'Gejala Tambah: ${patient.riwayatKeluhan?.gejalaTambah ?? 'N/A'}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
