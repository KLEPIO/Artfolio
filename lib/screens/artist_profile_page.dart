import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArtistProfilePage extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artist Profile'),
        backgroundColor: Colors.grey.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Words about the author'),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('artworks')
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
                    return Center(child: Text('No artworks available.'));
                  }

                  final artworks = snapshot.data!.docs;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: artworks.length,
                    itemBuilder: (context, index) 
                    {
                      final artwork = artworks[index];
                      final imageUrl = artwork['imageUrl'];

                      return Card(
                        child: Image.network(imageUrl, fit: BoxFit.cover),
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
