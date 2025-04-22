import 'package:Eye_Health/models/jadwal.dart';
import 'package:Eye_Health/services/jadwal.dart';
import 'package:flutter/material.dart';

class JadwalDokter extends StatefulWidget {
  final String id_dokter; // Receive the id_dokter passed as an argument

  JadwalDokter({required this.id_dokter});

  @override
  State<JadwalDokter> createState() => _JadwalDokterState();
}

class _JadwalDokterState extends State<JadwalDokter> {
  late Future<List<JadwalModel>>
      _jadwalFuture; // Store future data of schedules

  @override
  void initState() {
    super.initState();
    // Initialize the future with doctor ID passed from the parent widget
    _jadwalFuture =
        JadwalService().getJadwalByDoctorId(int.parse(widget.id_dokter));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JadwalModel>>(
      future: _jadwalFuture, // Use the future to fetch schedules
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while data is being fetched
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Show error message if an error occurs
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Show message if no data is available
          return Center(child: Text('No schedule available.'));
        } else {
          // Data fetched successfully, build the table
          List<JadwalModel> jadwalList = snapshot.data!;

          return Table(
            border: TableBorder.all(color: Colors.black),
            columnWidths: {
              0: FixedColumnWidth(60.0), // Width of the 'Hari' column
              1: FixedColumnWidth(120.0), // Width of the 'Waktu' column
              2: FlexColumnWidth(), // Width of the 'Lokasi' column
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hari',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Jam Praktek',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lokasi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              // Create table rows dynamically from the fetched jadwal list
              for (var jadwal in jadwalList)
                _buildTableRow(jadwal.hari, jadwal.jamPraktek, jadwal.lokasi),
            ],
          );
        }
      },
    );
  }

  // Helper method to build a table row with location
  TableRow _buildTableRow(String day, String time, String location) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(day),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(time),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(location),
          ),
        ),
      ],
    );
  }
}
