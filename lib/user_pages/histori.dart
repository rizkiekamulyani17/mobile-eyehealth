
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/histori_deteksi.dart';
import 'package:Eye_Health/models/histori_pemeriksaan.dart';
import 'package:Eye_Health/services/histori_deteksi.dart';
import 'package:Eye_Health/services/histori_pemeriksaan.dart';
import 'package:Eye_Health/user_pages/riwayat_detail.dart';
import 'package:Eye_Health/widgets/bottom_navigation.dart';
import 'package:Eye_Health/widgets/header.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';


class HistoriPage extends StatefulWidget {
  const HistoriPage({super.key});

  @override
  State<HistoriPage> createState() => _HistoriPageState();
}

class _HistoriPageState extends State<HistoriPage> {
  late Future<List<HistoriDeteksiModel>> _historiDeteksiFuture;
  late Future<List<RiwayatPemeriksaanModel>> _historiPemeriksaanFuture;
  ApiService _api = ApiService();

  @override
  void initState() {
    super.initState();
    _historiDeteksiFuture = HistoriService().fetchHistoriDeteksi();
    _historiPemeriksaanFuture =
        HistoriPemeriksaanService().fetchHistoriPemeriksaan();
  }

  void _refreshData() {
    setState(() {
      _historiDeteksiFuture = HistoriService().fetchHistoriDeteksi();
      _historiPemeriksaanFuture =
          HistoriPemeriksaanService().fetchHistoriPemeriksaan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: Header(),
        endDrawer: SideMenu(),
        body: Column(
          children: [
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Histori Deteksi"),
                Tab(text: "Histori Pemeriksaan"),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder<List<HistoriDeteksiModel>>(
                    future: _historiDeteksiFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final deteksiHistory = snapshot.data!;
                        if (deteksiHistory.isEmpty) {
                          return Center(child: Text('No data available.'));
                        }
                        return FutureBuilder<String>(
                          future: _api.getBaseUrl(),
                          builder: (context, baseUrlSnapshot) {
                            if (baseUrlSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (baseUrlSnapshot.hasError) {
                              return Center(
                                  child:
                                      Text('Error: ${baseUrlSnapshot.error}'));
                            } else if (baseUrlSnapshot.hasData) {
                              final baseUrl = baseUrlSnapshot.data!;
                              return SingleChildScrollView(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text('No')),
                                      DataColumn(label: Text('Gambar')),
                                      DataColumn(label: Text('Prediksi Kelas')),
                                      DataColumn(label: Text('Akurasi (%)')),
                                      DataColumn(
                                          label: Text('Rekomendasi Obat')),
                                      DataColumn(label: Text('Tanggal')),
                                      DataColumn(label: Text('Delete')),
                                    ],
                                    rows: deteksiHistory
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index = entry.key;
                                      var deteksi = entry.value;
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                              Text((index + 1).toString())),
                                          DataCell(
                                            deteksi.imgDeteksi.isNotEmpty
                                                ? Image.network(
                                                    "$baseUrl/static/uploads/${deteksi.imgDeteksi}",
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Text('No Image'),
                                          ),
                                          DataCell(
                                              Text(deteksi.predictedClass)),
                                          DataCell(Text(
                                              '${deteksi.confidence.toStringAsFixed(2)}%')),
                                          DataCell(Text(
                                            deteksi.obatRekomendasi.isNotEmpty
                                                ? deteksi.obatRekomendasi
                                                    .join(', ')
                                                : "Tidak ada rekomendasi obat",
                                          )),
                                          DataCell(Text(
                                              deteksi.timestamp.toString())),
                                          DataCell(
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () async {
                                                final confirmed =
                                                    await showDialog<bool>(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text(
                                                        'Delete Confirmation'),
                                                    content: Text(
                                                        'Are you sure you want to delete this item?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true),
                                                        child: Text('Delete'),
                                                      ),
                                                    ],
                                                  ),
                                                );

                                                if (confirmed ?? false) {
                                                  try {
                                                    await HistoriService()
                                                        .deleteHistoriDeteksi(
                                                            deteksi.id);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Deleted successfully'),
                                                    ));
                                                    _refreshData(); // Refresh the data
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Failed to delete: $e'),
                                                    ));
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            } else {
                              return Center(child: Text('No data available.'));
                            }
                          },
                        );
                      } else {
                        return Center(child: Text('No data available.'));
                      }
                    },
                  ),
                  FutureBuilder<List<RiwayatPemeriksaanModel>>(
                    future: _historiPemeriksaanFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final pemeriksaanHistory = snapshot.data!;
                        if (pemeriksaanHistory.isEmpty) {
                          return Center(child: Text('No data available.'));
                        }
                        return SingleChildScrollView(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('No')),
                                DataColumn(label: Text('Nama')),
                                DataColumn(label: Text('Keluhan Utama')),
                                DataColumn(label: Text('Masalah Penglihatan')),
                                DataColumn(label: Text('Tanggal Pemeriksaan')),
                              ],
                              rows: pemeriksaanHistory
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                var pemeriksaan = entry.value;
                                return DataRow(
                                  onSelectChanged: (_) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RiwayatDetailPage(
                                          pemeriksaan: pemeriksaan,
                                        ),
                                      ),
                                    );
                                  },
                                  cells: [
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(pemeriksaan.nama)),
                                    DataCell(Text(pemeriksaan.keluhanUtama)),
                                    DataCell(
                                        Text(pemeriksaan.masalahPenglihatan)),
                                    DataCell(
                                        Text(pemeriksaan.tanggalPemeriksaan)),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      } else {
                        return Center(child: Text('No data available.'));
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 70),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          selectedIndex: 0,
          pageIndex: 2,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _refreshData,
          child: Icon(Icons.refresh),
          tooltip: 'Refresh Data',
        ),
      ),
    );
  }
}
