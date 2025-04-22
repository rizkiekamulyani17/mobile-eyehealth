import 'package:Eye_Health/services/session.dart';
import 'package:Eye_Health/user_pages/login.dart';
import 'package:Eye_Health/user_pages/register.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final sessionService = SessionService();

  Future<bool> isTokenEmpty() async {
    final token = await sessionService.getToken();
    return token == null || token.isEmpty;
  }

  Future<String?> fetchUserRole() async {
    return await sessionService
        .getUserRole(); // Assume this method gets the user's role
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<bool>(
        future: isTokenEmpty(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show loading spinner
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          bool tokenEmpty = snapshot.data ?? true;

          return FutureBuilder<String?>(
            future: fetchUserRole(),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (roleSnapshot.hasError) {
                return Center(child: Text('Error: ${roleSnapshot.error}'));
              }

              String? userRole = roleSnapshot.data;

              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  tokenEmpty ? LoginBtn() : Container(),
                  tokenEmpty ? RegisterBtn() : Container(),
                  !tokenEmpty
                      ? ListTile(
                          leading: Icon(Icons.history),
                          title: Text('Histori'),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/histori', // Ensure route is set correctly in MaterialApp
                            );
                          },
                        )
                      : Container(),
                  ListTile(
                    leading: Icon(Icons.library_books_outlined),
                    title: Text('Blog'),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/blog', // Ensure route is set correctly in MaterialApp
                      );
                    },
                  ),
                  !tokenEmpty
                      ? ListTile(
                          leading: Icon(Icons.library_books_outlined),
                          title: Text('Profile Dokter'),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/profiledokter', // Ensure route is set correctly in MaterialApp
                            );
                          },
                        )
                      : Container(),
                  if (userRole != "dokter")
                    ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('About'),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/about', // Ensure route is set correctly in MaterialApp
                        );
                      },
                    ),
                  !tokenEmpty
                      ? ListTile(
                          leading: Icon(Icons.logout_rounded),
                          title: Text('Logout'),
                          onTap: () async {
                            await sessionService.clearSession();

                            Navigator.pushNamed(
                              context,
                              '/', // Ensure route is set correctly in MaterialApp
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Berhasil Logout',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                action: SnackBarAction(
                                  label: "Close",
                                  onPressed: () {},
                                  textColor: Colors.white,
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        )
                      : Container(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class RegisterBtn extends StatelessWidget {
  const RegisterBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.app_registration),
      title: Text('Register'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
    );
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.login),
      title: Text('Login'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
    );
  }
}
