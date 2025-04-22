
import 'package:Eye_Health/widgets/messagedetail.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';

class ChatDokterPage extends StatefulWidget {
  const ChatDokterPage({super.key});

  @override
  State<ChatDokterPage> createState() => _ChatDokterPageState();
}

class _ChatDokterPageState extends State<ChatDokterPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: Header(),
        endDrawer: SideMenu(),
        body: Column(
          children: [
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Pesan Masuk"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[400],
                          ),
                          title: Text('Dr Ahmad'),
                          subtitle: Text(
                              'This message is inside a bordered ListTile.'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessageDetailPage(
                                  senderName: 'Dr Ahmad',
                                  message:
                                      'This message is inside a bordered ListTile.',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          selectedIndex: 2,
          pageIndex: 2,
        ),
      ),
    );
  }
}
