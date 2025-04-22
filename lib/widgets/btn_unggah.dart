import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart'; // Import the uuid package

class BtnUnggah extends StatefulWidget {
  final void Function(XFile image) onImageSelected; // Callback function

  const BtnUnggah({super.key, required this.onImageSelected});

  @override
  _BtnUnggahState createState() => _BtnUnggahState();
}

class _BtnUnggahState extends State<BtnUnggah> {
  XFile? _selectedImage; // To store the picked image
  var uuid = Uuid(); // Create an instance of the UUID generator

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        // Generate a unique name for the image using UUID (optional)
        String uniqueImageName = "image_${uuid.v4()}.jpg";

        // Store the image locally for display (if needed)
        _selectedImage = image;

        // Pass the selected image back to the parent widget using the callback
        widget.onImageSelected(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Button to upload a file
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(54, 91, 109, 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  // Reset the image when button is pressed (optional)
                  setState(() {
                    _selectedImage = null; // Clear the selected image
                  });

                  // Show the modal to choose the image source
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      height: 200,
                      color: Colors.white,
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {
                              _pickImage(
                                  ImageSource.gallery); // Pick from gallery
                              Navigator.pop(context); // Close modal
                            },
                            leading: const Icon(Icons.photo),
                            title: const Text("Photo"),
                          ),
                          ListTile(
                            onTap: () {
                              _pickImage(
                                  ImageSource.camera); // Pick from camera
                              Navigator.pop(context); // Close modal
                            },
                            leading: const Icon(Icons.camera),
                            title: const Text("Camera"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text(
                  _selectedImage == null
                      ? "Choose File"
                      : "File Selected", // Show a different prompt or file name
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Displaying the selected image if available
      ],
    );
  }
}
