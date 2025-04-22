import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/services/session.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final int pageIndex;

  const BottomNavigation({
    super.key,
    required this.pageIndex,
    required this.selectedIndex,
  });

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;
  late int _pageIndex;
  final sessionService = SessionService();
  final api = ApiService();
  bool _isButtonTapped = false;
  bool _isTokenValid = false;
  String? _userRole;
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _pageIndex = widget.pageIndex;
    _initializeState();
  }

  Future<void> _initializeState() async {
    await _checkToken();
    await _fetchUserRole();
    _loadBaseUrl(); // Load base URL on initialization
  }

  Future<void> _checkToken() async {
    final token = await sessionService.getToken();
    setState(() {
      _isTokenValid = token != null && token.isNotEmpty;
    });
  }

  Future<void> _fetchUserRole() async {
    final role = await sessionService.getUserRole();
    setState(() {
      _userRole = role;
    });
  }

  Future<void> _loadBaseUrl() async {
    await api.getBaseUrl(); // Ensure ApiService initializes the base URL
  }

  void _onItemTapped(int index) async {
    if (_isButtonTapped) return;

    setState(() {
      _isButtonTapped = true;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isButtonTapped = false;
      });
    });

    if (index == _selectedIndex && index == _pageIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/chatbot');
        break;
      case 2:
        if (_isTokenValid) {
          Navigator.pushNamed(context, '/profile');
        } else {
          Navigator.pushNamed(context, '/login');
        }
        break;
    }
  }

  void _showChangeBaseUrlDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Change Base URL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: 'Enter new Base URL',
                    hintText: 'e.g., https://newurl.com',
                  ),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String newBaseUrl = _urlController.text.trim();
                    if (newBaseUrl.isNotEmpty) {
                      api.baseUrl = newBaseUrl;
                      Navigator.pop(context);
                      _showSuccessDialog();
                    } else {
                      print("Base URL cannot be empty.");
                    }
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Base URL has been updated successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: const Color.fromRGBO(174, 255, 251, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => _onItemTapped(0),
            onLongPress: _showChangeBaseUrlDialog,
            child: _buildItem(const Icon(Icons.home_filled), "Home", 0),
          ),
          if (_userRole != "dokter")
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: _buildItem(
                const ImageIcon(
                  AssetImage('assets/icons/mage_robot-happy.png'),
                  size: 25,
                ),
                "Chatbot",
                1,
              ),
            ),
          if (_isTokenValid)
            GestureDetector(
              onTap: () => _onItemTapped(2),
              child: _buildItem(
                const Icon(Icons.account_circle_outlined),
                "Profile",
                2,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItem(Widget icon, String label, int index) {
    final bool isSelected = index == _selectedIndex;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(height: isSelected ? 3.0 : 0),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontSize: isSelected ? 14.0 : 12.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
