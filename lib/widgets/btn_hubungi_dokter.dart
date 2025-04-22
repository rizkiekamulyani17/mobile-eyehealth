// import 'package:flutter/material.dart';
// import 'package:mobile/user_pages/formpendaftaran.dart';
// import 'package:mobile/widgets/jadwaldokter.dart';

// class BtnHubungiDokter extends StatelessWidget {
//   const BtnHubungiDokter({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 1,
//       child: Container(
//         height: 40, // Set height for the button
//         decoration: BoxDecoration(
//           color: const Color.fromRGBO(33, 150, 243, 1), // Blue button color
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: TextButton(
//           onPressed: () {
//             showModalBottomSheet(
//               backgroundColor: Color.fromRGBO(245, 245, 245, 1),
//               context: context,
//               isScrollControlled:
//                   true, // Allow the height to be controlled by content
//               builder: (context) => Container(
//                 height: 600,
//                 padding:
//                     const EdgeInsets.all(16.0), // Add padding around content
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   // Wrap the content in SingleChildScrollView
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Berikut Daftar Jadwal Dokter M. ARIEF MUNANDAR, Sp. M",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 20), // Space between text and table
//                       JadwalDokter(),
//                       Text(
//                         "Klik tombol di bawah ini untuk mendaftar pemeriksaan",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => FormPendaftaranPage()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           padding: EdgeInsets.symmetric(horizontal: 30),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(32.0),
//                           ),
//                         ),
//                         child: const Text(
//                           "Daftar Pemeriksaan",
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 250,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Text(
//                           "Apakah ada yang perlu dikonsultasikan dengan Dokter M. ARIEF MUNANDAR, Sp. M?",
//                           style: TextStyle(
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         margin:
//                             EdgeInsets.only(left: 20, right: 20, bottom: 20),
//                         padding: EdgeInsets.only(top: 10, left: 20),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[400],
//                           borderRadius: BorderRadius.circular(28),
//                         ),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Type your message...',
//                             hintStyle: TextStyle(
//                               fontSize: 18,
//                             ),
//                             suffixIcon: IconButton(
//                                 icon: Icon(
//                                   Icons.send,
//                                 ),
//                                 padding: EdgeInsets.only(bottom: 10),
//                                 onPressed:
//                                     () {} // Send message when button is pressed
//                                 ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//           child: const Text(
//             "Hubungi Dokter",
//             style: TextStyle(
//               color: Colors.white, // Text color
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
