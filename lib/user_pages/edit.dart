import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/services/edit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers for the fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _tempatController = TextEditingController();
  TextEditingController _tanggalLahirController = TextEditingController();

  File? _profilePicture; // Holds the selected image file
  bool _isLoading = false;
  String? _profilePictureUrl;
  ApiService _api = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Fetch user profile from the API
  Future<void> _fetchUserProfile() async {
    try {
      String baseUrl = await _api.getBaseUrl();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.get(
        Uri.parse('$baseUrl/api/user-details'),
        headers: {
          'X-Token': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          _nameController.text = data['name'];
          _emailController.text = data['email'];
          _alamatController.text = data['alamat'];
          _tempatController.text = data['tempat'];
          _tanggalLahirController.text = DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(data['tanggal_lahir']));
          _profilePictureUrl =
              "$baseUrl/static/uploads/${data['profile_picture']}"; // Update profile picture URL
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading profile: $e')),
      );
    }
  }

  // Pick an image using the ImagePicker
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  // Submit the form to update user profile using UserEditService
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var updatedData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'alamat': _alamatController.text,
        'tempat': _tempatController.text,
        'tanggal_lahir': _tanggalLahirController.text,
      };

      try {
        // Use UserEditService to update the profile, including the profile picture
        await UserEditService()
            .updateUserProfile(updatedData, profilePicture: _profilePicture);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Open the date picker
  Future<void> _selectDate() async {
    DateTime initialDate;
    try {
      initialDate = DateTime.parse(_tanggalLahirController.text);
    } catch (_) {
      initialDate = DateTime.now();
    }
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1700),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePicture != null
                      ? FileImage(_profilePicture!)
                      : _profilePictureUrl != null
                          ? NetworkImage(
                              _profilePictureUrl!) // Use network image if available
                          : AssetImage('assets/icons/app_icon.png')
                              as ImageProvider,
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: _pickImage,
                child: Text('Change Profile Picture'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tempatController,
                decoration: InputDecoration(labelText: 'Tempat Lahir'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your place';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tanggalLahirController,
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                readOnly: true,
                onTap: _selectDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth';
                  } else if (DateTime.tryParse(value) == null) {
                    return 'Please enter a valid date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
