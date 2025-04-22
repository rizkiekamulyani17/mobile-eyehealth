import 'package:Eye_Health/models/dokter.dart';
import 'package:Eye_Health/services/dokter.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';

class ProfileDoktorkPage extends StatefulWidget {
  @override
  _ProfileDoktorkPageState createState() => _ProfileDoktorkPageState();
}

class _ProfileDoktorkPageState extends State<ProfileDoktorkPage> {
  late List<DokterModel> allDokter = [];
  late int displayedCount = allDokter.length; // Initially display 10 items
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllDokter(); // Fetch initial data on load
  }

  Future<void> fetchAllDokter() async {
    setState(() => isLoading = true);
    try {
      allDokter = await DokterService().fetchDokters();
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> openDokterLink(String link) async {
    Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $link");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      endDrawer: SideMenu(),
      body: Column(
        children: [
          Center(
            child: Text(
              "Profile Doktor",
              style: TextStyle(
                color: Color.fromRGBO(51, 145, 255, 1),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          padding: EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: displayedCount,
                          itemBuilder: (context, index) {
                            final dokter = allDokter[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (dokter.profileImg != null)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          dokter.profileImg!,
                                          height: 100,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.broken_image,
                                                size: 100, color: Colors.grey);
                                          },
                                        ),
                                      ),
                                    SizedBox(height: 8),
                                    Text(
                                      dokter.name ?? 'No title',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () =>
                                            openDokterLink(dokter.tentang!),
                                        child: Text(
                                          "Read More",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 0,
        pageIndex: 10,
      ),
    );
  }
}
