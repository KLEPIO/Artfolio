import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class UploadArtworkPage extends StatefulWidget 
{
  @override
  _UploadArtworkPageState createState() => _UploadArtworkPageState();
}

class _UploadArtworkPageState extends State<UploadArtworkPage> 
{
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  bool _isLoading = false;

  Future<void> _pickImage() async 
  {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() 
    {
      if (pickedFile != null) 
      {
        _image = File(pickedFile.path);
      } 
        else 
      {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadArtwork() async 
  {
    if (_image == null || _detailsController.text.isEmpty || _titleController.text.isEmpty) 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide an image, title, and details')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try 
    {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child('artworks/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask.whenComplete(() => null);
      String imageUrl = await storageReference.getDownloadURL();

      await FirebaseFirestore.instance.collection('artworks').add(
      {
        'imageUrl': imageUrl,
        'title': _titleController.text,
        'details': _detailsController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': FirebaseAuth.instance.currentUser!.uid, 
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Artwork uploaded successfully')),
      );

      setState(() 
      {
        _image = null;
        _titleController.clear();
        _detailsController.clear();
      });
    } catch (e) 
    {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload artwork')),
      );
    } finally 
    {
      setState(() 
      {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Artwork'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _image == null
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.add_a_photo, size: 50),
                    )
                  : Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title of the artwork',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Details about the artwork',
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _uploadArtwork,
                    child: Text('Upload'),
                  ),
          ],
        ),
      ),
    );
  }
}
