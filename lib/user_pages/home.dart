import 'package:Eye_Health/services/session.dart';
import 'package:Eye_Health/widgets/btn_cek_kesehatan_mata.dart';
import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/side_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final sessionService = SessionService();
  String? _userRole;

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    final role = await sessionService.getUserRole(); // Fetch the user role
    setState(() {
      _userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      endDrawer: SideMenu(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        children: [
          // Image Section
          SizedBox(height: 50), // Add top spacing
          SizedBox(
            height: 250,
            child: Image.asset(
              "assets/img/home.png",
              fit: BoxFit.cover, // Ensures the image covers the area
            ),
          ),
          // Eye Health Text Section
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Eye",
                style: TextStyle(
                  color: Color.fromRGBO(54, 91, 109, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Health",
                style: TextStyle(
                  color: Color.fromRGBO(54, 91, 109, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          SizedBox(
              height: 40), // Add spacing between the titles and the description

          // Eye Health Description Text Section
          Text(
            "Menjaga kesehatan mata adalah hal paling utama karena mata adalah salah satu organ dalam tubuh yang sangat penting dalam melakukan aktivitas sehari - hari, ayoo!! kita jaga kesehatan mata kita dengan Gizi dan aktivitas yang cukup !!",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 40), // Spacing for better layout

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_userRole != "dokter") ...[
                btn_cek_kesehatan_mata(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chatbot');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/mage_robot-happy.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Chatbot',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/monitoring');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  label: Text(
                    "Monitoring",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(
                    Icons.monitor_sharp,
                    color: Colors.white,
                    size: 25,
                    weight: 800,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/rating');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  label: Text(
                    "Rating App",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 25,
                    weight: 800,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 0,
        pageIndex: 0,
      ),
    );
  }
}
