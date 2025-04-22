import 'package:Eye_Health/services/daftarpemeriksaan.dart';
import 'package:Eye_Health/widgets/jadwaldokter.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';

class FormPendaftaranPage extends StatefulWidget {
  final String id_dokter; // Receive the id_dokter passed as an argument

  FormPendaftaranPage({required this.id_dokter});

  @override
  State<FormPendaftaranPage> createState() => _FormPendaftaranPageState();
}

class _FormPendaftaranPageState extends State<FormPendaftaranPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController tanggalC = TextEditingController();
  TextEditingController tanggalJadwalC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController noHandphoneC = TextEditingController();
  TextEditingController pekerjaanC = TextEditingController();
  TextEditingController riwayatKeluargaC = TextEditingController();
  TextEditingController penyakitSedangDiobatiC = TextEditingController();
  TextEditingController alergiObatC = TextEditingController();
  TextEditingController keluhanC = TextEditingController();
  TextEditingController gejalaTambahanC = TextEditingController();
  TextEditingController keluhanTambahanC = TextEditingController();
  TextEditingController keluhanSejakC = TextEditingController();
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool masalahpenglihatan_ya = false;
  bool masalahpenglihatan_tidak = false;
  bool penggunakacamata_ya = false;
  bool penggunakacamata_tidak = false;
  bool penyakitmatakeluarga_ya = false;
  bool penyakitmatakeluarga_tidak = false;
  bool penyakitsedangdiobati_ya = false;
  bool penyakitsedangdiobati_tidak = false;
  bool alegiobat_ya = false;
  bool alegiobat_tidak = false;
  bool keluhan_ya = false;
  bool keluhan_tidak = false;
  bool gejalatambahan_ya = false;
  bool gejalatambahan_tidak = false;

  String getJenisKelamin() {
    if (isMaleSelected) {
      return "Laki-Laki";
    } else if (isFemaleSelected) {
      return "Perempuan";
    }
    return "Tidak Diketahui"; // Default value if neither is selected
  }

  String getMasalahPenglihatan() {
    return masalahpenglihatan_ya ? "YA" : "TIDAK";
  }

  String getMenggunakanKacamata() {
    return penggunakacamata_ya ? "YA" : "TIDAK";
  }

  String getPenyakitMataKeluarga() {
    return penyakitmatakeluarga_ya ? "YA" : "TIDAK";
  }

  String getPenyakitSedangDiobati() {
    return penyakitsedangdiobati_ya ? "YA" : "TIDAK";
  }

  String getAlergiObat() {
    return alegiobat_ya ? "YA" : "TIDAK";
  }

  String getKeluhan() {
    return keluhan_ya ? "YA" : "TIDAK";
  }

  String getGejalaTambahan() {
    return gejalatambahan_ya ? "YA" : "TIDAK";
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Collect data from controllers
      Map<String, dynamic> patientData = {
        'id_dokter': int.parse(widget.id_dokter),
        'nama': namaC.text,
        'tanggal_pemeriksaan': tanggalJadwalC.text,
        'tanggal_lahir': tanggalC.text,
        'jenis_kelamin': getJenisKelamin(),
        'alamat': alamatC.text,
        'nomor_hp': noHandphoneC.text,
        'pekerjaan': pekerjaanC.text,
        'masalah_penglihatan': getMasalahPenglihatan(),
        'menggunakan_kacamata': getMenggunakanKacamata(),
        'riwayat_keluarga': getPenyakitMataKeluarga(),
        'penjelasan_keluarga': riwayatKeluargaC.text,
        'penyakit_lain': getPenyakitSedangDiobati(),
        'penjelasan_penyakit': penyakitSedangDiobatiC.text,
        'alergi_obat': getAlergiObat(),
        'penjelasan_alergi': alergiObatC.text,
        'keluhan_utama': keluhanC.text,
        'sejak_kapan': keluhanSejakC.text,
        'keluhan_perubahan': getKeluhan(),
        'penjelasan_keluhan': keluhanTambahanC.text,
        'gejala_tambah': getGejalaTambahan(),
        'penjelasan_gejala': gejalaTambahanC.text,
      };

      // Call the register method
      try {
        DaftarPemeriksaan daftarPemeriksaan = DaftarPemeriksaan();
        await daftarPemeriksaan.daftar(patientData);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Daftar Berhasil")));
        Navigator.pushNamed(
          context,
          '/', // Ensure route is set correctly in MaterialApp
        );
        // Show success message
      } catch (e) {
        // Handle error (show error message)
        print('Error: $e');
      }
    }
  }

  Future<void> _selectDateJadwal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        tanggalJadwalC.text =
            DateFormat('yyyy-MM-dd').format(picked); // Format the date
      });
    }
  }

  Future<void> _selectTanggalLahir() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        tanggalC.text =
            DateFormat('yyyy-MM-dd').format(picked); // Format the date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      endDrawer: SideMenu(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          children: [
            Text(
              "FORMULIR PENDAFTARAN PASIEN",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Tanggal Pemeriksaan yang diinginkan"),
            SizedBox(
              height: 10,
            ),
            JadwalDokter(id_dokter: widget.id_dokter),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: tanggalJadwalC,
              decoration: const InputDecoration(
                labelText: "Pilih Tanggal Sesuai Jadwal", // Date of Birth
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak Boleh Kosong!';
                }
                return null;
              },
              readOnly: true,
              onTap: () {
                _selectDateJadwal(); // Open date picker on tap
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "A. DATA PASIEN",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextFormField(
              controller: namaC,
              autocorrect: false,
              decoration: InputDecoration(
                label: Text("Nama Lengkap"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak Boleh Kosong!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: tanggalC,
              decoration: const InputDecoration(
                labelText: "Tanggal Lahir", // Date of Birth
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak Boleh Kosong!';
                }
                return null;
              },
              readOnly: true,
              onTap: () {
                _selectTanggalLahir(); // Open date picker on tap
              },
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Jenis Kelamin",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Male checkbox
                Row(
                  children: [
                    Checkbox(
                      value: isMaleSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Male" is selected, unselect "Female"
                          isMaleSelected = value!;
                          if (isMaleSelected) {
                            isFemaleSelected = false;
                          }
                        });
                      },
                    ),
                    Text('Laki - Laki'),
                  ],
                ),

                // Female checkbox
                Row(
                  children: [
                    Checkbox(
                      value: isFemaleSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Female" is selected, unselect "Male"
                          isFemaleSelected = value!;
                          if (isFemaleSelected) {
                            isMaleSelected = false;
                          }
                        });
                      },
                    ),
                    Text('Perempuan'),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: alamatC,
              autocorrect: false,
              decoration: InputDecoration(
                label: Text("Alamat"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak Boleh Kosong!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: noHandphoneC,
              autocorrect: false,
              decoration: InputDecoration(
                label: Text("No. Handphone"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak Boleh Kosong!';
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: pekerjaanC,
              autocorrect: false,
              decoration: InputDecoration(
                label: Text("Pekerjaan"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak Boleh Kosong!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "B. RIWAYAT MEDIS",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Apakah Anda pernah memiliki masalah penglihatan sebelumnya?",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Male checkbox
                Row(
                  children: [
                    Checkbox(
                      value: masalahpenglihatan_ya,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Male" is selected, unselect "Female"
                          masalahpenglihatan_ya = value!;
                          if (masalahpenglihatan_ya) {
                            masalahpenglihatan_tidak = false;
                          }
                        });
                      },
                    ),
                    Text('Ya'),
                  ],
                ),

                // Female checkbox
                Row(
                  children: [
                    Checkbox(
                      value: masalahpenglihatan_tidak,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Female" is selected, unselect "Male"
                          masalahpenglihatan_tidak = value!;
                          if (masalahpenglihatan_tidak) {
                            masalahpenglihatan_ya = false;
                          }
                        });
                      },
                    ),
                    Text('Tidak'),
                  ],
                ),
              ],
            ),
            //penggunnaan kacamata
            SizedBox(
              height: 5,
            ),
            Text(
              "Apakah Anda sedang menggunakan kacamata atau lensa kontak?",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Male checkbox
                Row(
                  children: [
                    Checkbox(
                      value: penggunakacamata_ya,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Male" is selected, unselect "Female"
                          penggunakacamata_ya = value!;
                          if (penggunakacamata_ya) {
                            penggunakacamata_tidak = false;
                          }
                        });
                      },
                    ),
                    Text('Ya'),
                  ],
                ),

                // Female checkbox
                Row(
                  children: [
                    Checkbox(
                      value: penggunakacamata_tidak,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Female" is selected, unselect "Male"
                          penggunakacamata_tidak = value!;
                          if (penggunakacamata_tidak) {
                            penggunakacamata_ya = false;
                          }
                        });
                      },
                    ),
                    Text('Tidak'),
                  ],
                ),
              ],
            ),
            // penyakit mata keluarga
            SizedBox(
              height: 5,
            ),
            Text(
              "Apakah Anda memiliki riwayat penyakit mata dalam keluarga?",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Male checkbox
                Row(
                  children: [
                    Checkbox(
                      value: penyakitmatakeluarga_ya,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Male" is selected, unselect "Female"
                          penyakitmatakeluarga_ya = value!;
                          if (penyakitmatakeluarga_ya) {
                            penyakitmatakeluarga_tidak = false;
                          }
                        });
                      },
                    ),
                    Text('Ya'),
                  ],
                ),

                // Female checkbox
                Row(
                  children: [
                    Checkbox(
                      value: penyakitmatakeluarga_tidak,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Female" is selected, unselect "Male"
                          penyakitmatakeluarga_tidak = value!;
                          if (penyakitmatakeluarga_tidak) {
                            penyakitmatakeluarga_ya = false;
                          }
                        });
                      },
                    ),
                    Text('Tidak'),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: riwayatKeluargaC,
              autocorrect: false,
              enabled: penyakitmatakeluarga_ya ? true : false,
              decoration: InputDecoration(
                label: Text("Jika Ya, Maka Jelaskan"),
              ),
            ),

            SizedBox(
              height: 5,
            ),
            Text(
              "Apakah Anda memiliki penyakit lain yang sedang diobati?",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Male checkbox
                Row(
                  children: [
                    Checkbox(
                      value: penyakitsedangdiobati_ya,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Male" is selected, unselect "Female"
                          penyakitsedangdiobati_ya = value!;
                          if (penyakitsedangdiobati_ya) {
                            penyakitsedangdiobati_tidak = false;
                          }
                        });
                      },
                    ),
                    Text('Ya'),
                  ],
                ),

                // Female checkbox
                Row(
                  children: [
                    Checkbox(
                      value: penyakitsedangdiobati_tidak,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Female" is selected, unselect "Male"
                          penyakitsedangdiobati_tidak = value!;
                          if (penyakitsedangdiobati_tidak) {
                            penyakitsedangdiobati_ya = false;
                          }
                        });
                      },
                    ),
                    Text('Tidak'),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: penyakitSedangDiobatiC,
              autocorrect: false,
              enabled: penyakitsedangdiobati_ya ? true : false,
              decoration:
                  InputDecoration(label: Text("Jika Ya, Maka Jelaskan")),
            ),

            // alergi obat
            SizedBox(
              height: 5,
            ),
            Text(
              "Apakah Anda alergi terhadap obat atau bahan tertentu?",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Male checkbox
                Row(
                  children: [
                    Checkbox(
                      value: alegiobat_ya,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Male" is selected, unselect "Female"
                          alegiobat_ya = value!;
                          if (alegiobat_ya) {
                            alegiobat_tidak = false;
                          }
                        });
                      },
                    ),
                    Text('Ya'),
                  ],
                ),

                // Female checkbox
                Row(
                  children: [
                    Checkbox(
                      value: alegiobat_tidak,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Female" is selected, unselect "Male"
                          alegiobat_tidak = value!;
                          if (alegiobat_tidak) {
                            alegiobat_ya = false;
                          }
                        });
                      },
                    ),
                    Text('Tidak'),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: alergiObatC,
              autocorrect: false,
              enabled: alegiobat_ya ? true : false,
              decoration:
                  InputDecoration(label: Text("Jika Ya, Maka Jelaskan")),
            ),

            SizedBox(
              height: 20,
            ),
            Text(
              "C. KELUHAN MATA SAAT INI",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextFormField(
              controller: keluhanC,
              autocorrect: false,
              decoration: InputDecoration(
                label: Text("Apa keluhan utama yang Anda rasakan saat ini?"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak Boleh Kosong!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: keluhanSejakC,
              autocorrect: false,
              decoration: InputDecoration(
                label: Text("Sejak kapan keluhan ini dirasakan?"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak Boleh Kosong!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Apakah keluhan ini semakin memburuk atau membaik?",
              style: TextStyle(
                fontSize: 17,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Male checkbox
                Row(
                  children: [
                    Checkbox(
                      value: keluhan_ya,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Male" is selected, unselect "Female"
                          keluhan_ya = value!;
                          if (keluhan_ya) {
                            keluhan_tidak = false;
                          }
                        });
                      },
                    ),
                    Text('Ya'),
                  ],
                ),

                // Female checkbox
                Row(
                  children: [
                    Checkbox(
                      value: keluhan_tidak,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Female" is selected, unselect "Male"
                          keluhan_tidak = value!;
                          if (keluhan_tidak) {
                            keluhan_ya = false;
                          }
                        });
                      },
                    ),
                    Text('Tidak'),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: keluhanTambahanC,
              autocorrect: false,
              enabled: keluhan_ya ? true : false,
              decoration:
                  InputDecoration(label: Text("Jika Ya, Maka Jelaskan")),
            ),

            SizedBox(
              height: 5,
            ),
            Text(
              "Apakah ada gejala tambahan seperti mata merah, berair, atau gatal?",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Male checkbox
                Row(
                  children: [
                    Checkbox(
                      value: gejalatambahan_ya,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Male" is selected, unselect "Female"
                          gejalatambahan_ya = value!;
                          if (gejalatambahan_ya) {
                            gejalatambahan_tidak = false;
                          }
                        });
                      },
                    ),
                    Text('Ya'),
                  ],
                ),

                // Female checkbox
                Row(
                  children: [
                    Checkbox(
                      value: gejalatambahan_tidak,
                      onChanged: (bool? value) {
                        setState(() {
                          // If "Female" is selected, unselect "Male"
                          gejalatambahan_tidak = value!;
                          if (gejalatambahan_tidak) {
                            gejalatambahan_ya = false;
                          }
                        });
                      },
                    ),
                    Text('Tidak'),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: gejalaTambahanC,
              autocorrect: false,
              enabled: gejalatambahan_ya ? true : false,
              decoration:
                  InputDecoration(label: Text("Jika Ya, Maka Jelaskan")),
            ),

            SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  // Handle form submission
                  _submitForm();

                  print('Form submitted');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text(
                "Kirim",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 1,
        pageIndex: 1,
      ),
    );
  }
}
