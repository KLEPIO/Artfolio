import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ArtworkDetailsPage extends StatefulWidget 
{
  final String imageUrl;
  final String title;
  final String details;

  ArtworkDetailsPage
  ({
    required this.imageUrl, 
    required this.title, 
    required this.details
  });

  @override
  _ArtworkDetailsPageState createState() => _ArtworkDetailsPageState();
}

class _ArtworkDetailsPageState extends State<ArtworkDetailsPage> 
{
  final TextEditingController _commentController = TextEditingController();
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  bool _isLiked = false;

  void _submitComment() async 
  {
    if (_commentController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('comments').add(
    {
      'text': _commentController.text,
      'sender': _currentUser!.email,
      'timestamp': FieldValue.serverTimestamp(),
      'imageUrl': widget.imageUrl,
    });

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artwork Details'),
        backgroundColor: Colors.grey.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.imageUrl),
            SizedBox(height: 10),
            Text(
              widget.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(widget.details),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () 
                  {
                    setState(() 
                    {
                      _isLiked = !_isLiked;
                    });
                  },
                ),
                SizedBox(width: 10),
                Text('Leave a comment'),
              ],
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Enter your comment...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitComment,
              child: Text('Submit'),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('comments')
                    .where('imageUrl', isEqualTo: widget.imageUrl)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) 
                {
                  if (snapshot.connectionState == ConnectionState.waiting) 
                  {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) 
                  {
                    return Center(child: Text('No comments available.'));
                  }

                  final comments = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) 
                    {
                      final comment = comments[index];
                      return ListTile(
                        title: Text(comment['text']),
                        subtitle: Text('Sent by: ${comment['sender']}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
