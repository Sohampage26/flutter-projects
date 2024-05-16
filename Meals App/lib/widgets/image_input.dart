import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  bool _isUploading = false;

  void _takePicture() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 150, imageQuality: 50);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No image selected to upload.")),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    var uuid = const Uuid();
    String uniqueFileName = uuid.v1();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('$uniqueFileName.jpg');

    try {
      await storageRef.putFile(_selectedImage!);
      String downloadUrl = await storageRef.getDownloadURL();
      Navigator.of(context).pop(downloadUrl);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: $e")),
      );
    }

    setState(() {
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Image Input'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey,
              foregroundImage:
                  _selectedImage != null ? FileImage(_selectedImage!) : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera, color: Colors.white),
              label: const Text('Get Picture',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isUploading ? null : _uploadImage,
              icon: _isUploading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : const Icon(Icons.upload, color: Colors.white),
              label: Text(
                _isUploading ? 'Uploading...' : 'Upload Picture',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
