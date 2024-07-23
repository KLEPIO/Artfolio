import 'package:artfolio/components/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserPage extends StatefulWidget {
  UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  Future<List<DocumentSnapshot>> getUserImages() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("UserImages")
        .where("userId", isEqualTo: currentUser!.uid)
        .get();
    return querySnapshot.docs;
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        await _uploadImage();
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      // Upload image to Firebase Storage
      String fileName = _imageFile!.path.split('/').last;
      Reference storageReference =
          FirebaseStorage.instance.ref().child('user_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Save the image URL to Firestore
      await FirebaseFirestore.instance.collection("UserImages").add({
        'userId': currentUser!.uid,
        'imageUrl': downloadURL,
        'timestamp': Timestamp.now(),
      });

      setState(() {
        _imageFile = null;
      });
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade500,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();
            return Column(
              children: [
                Text(user!['email']),
                Text(user['username']),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text("Upload Image"),
                ),
                Expanded(
                  child: FutureBuilder<List<DocumentSnapshot>>(
                    future: getUserImages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        List<DocumentSnapshot> images = snapshot.data!;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            String imageUrl = images[index]['imageUrl'];
                            return Image.network(imageUrl);
                          },
                        );
                      } else {
                        return Text("No images found");
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Text("No data");
          }
        },
      ),
    );
  }
}
