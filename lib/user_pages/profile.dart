import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/user.dart';
import 'package:Eye_Health/services/user_detail.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';
import '../widgets/profile_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isHidden1 = true;
  bool isHidden2 = true;
  bool isHidden3 = true;
  bool isLoading = false;
  TextEditingController pass_lamaC = TextEditingController();
  TextEditingController pass_baruC = TextEditingController();
  TextEditingController konfirmasi_passC = TextEditingController();
  ApiService _api = ApiService();
  late Future<String> _baseUrlFuture; // Declare a Future for the baseUrl

  @override
  void initState() {
    super.initState();
    // Fetch the base URL asynchronously in initState
    _baseUrlFuture = _api.getBaseUrl();
  }

  // Fetch user data from API
  Future<UserModel> getUser() async {
    try {
      UserDetail _userDetail = UserDetail();
      return await _userDetail
          .getUserDetails(); // Use the service to get user details
    } catch (e) {
      throw Exception('Failed to load user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      endDrawer: SideMenu(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: [
          SizedBox(height: 40),
          // FutureBuilder for baseUrl and user data
          FutureBuilder<String>(
            future: _baseUrlFuture, // Use Future for baseUrl
            builder: (context, baseUrlSnapshot) {
              if (baseUrlSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (baseUrlSnapshot.hasError) {
                return Center(
                    child: Text(
                        'Error fetching base URL: ${baseUrlSnapshot.error}'));
              } else if (!baseUrlSnapshot.hasData) {
                return Center(child: Text('No base URL found'));
              } else {
                final baseUrl = baseUrlSnapshot.data!;
                return FutureBuilder<UserModel>(
                  future: getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No user data found'));
                    } else {
                      final user = snapshot.data!;
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "${baseUrl}/static/uploads/${user.gambar}" ??
                                    "https://picsum.photos/seed/picsum/200/300"),
                          ),
                          SizedBox(height: 20),
                          ProfileInfo(user: user),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/edit',
                              );
                            },
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      );
                    }
                  },
                );
              }
            },
          ),
          // Password change fields
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password Lama :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: pass_lamaC,
                autocorrect: false,
                keyboardType: TextInputType.text,
                obscureText: isHidden1,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden1 = !isHidden1;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Password Baru :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: pass_baruC,
                autocorrect: false,
                keyboardType: TextInputType.text,
                obscureText: isHidden2,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden2 = !isHidden2;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Konfirmasi Password :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: konfirmasi_passC,
                autocorrect: false,
                keyboardType: TextInputType.text,
                obscureText: isHidden3,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden3 = !isHidden3;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      UserDetail _userDetail = UserDetail();
                      bool success = await _userDetail.changePassword(
                        pass_lamaC.text,
                        pass_baruC.text,
                        konfirmasi_passC.text,
                      );

                      if (success) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Password Berhasil Diubah"),
                              content: const Text(
                                  "Selamat! Password Anda berhasil diubah."),
                              actions: [
                                TextButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } catch (e) {
                      // If it's a specific error (e.g., "Current password is incorrect"), show that error in the SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('$e'),
                      ));
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
                    "Ubah",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 2,
        pageIndex: 2,
      ),
    );
  }
}
