import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meals/widgets/image_input.dart';

class ImageUp extends StatefulWidget {
  const ImageUp({super.key});

  @override
  State<ImageUp> createState() {
    return _ImageUpState();
  }
}

class _ImageUpState extends State<ImageUp> {
  List<String> imageData = [];
  void punshnoti() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    print(token);
    fcm.subscribeToTopic('noti');
  }

  @override
  void initState() {
    super.initState();
    _getImageData();
    punshnoti();
  }

  Future<void> _getImageData() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('images');
      final ListResult result = await storageRef.listAll();
      setState(() {
        imageData = result.items.map((item) => item.name).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error fetching image names: ${e}"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _navigateAndGetImage() async {
    final String? receivedUrl = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ImageInput()),
    );

    if (receivedUrl != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Image uploaded: $receivedUrl"),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Image Upload Fail"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Item'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Image',
            onPressed: _navigateAndGetImage,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: imageData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(imageData[index]),
            );
          }),
    );
  }
}
