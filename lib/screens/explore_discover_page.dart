import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:artfolio/screens/artwork_details_page.dart';

class ExploreDiscoverPage extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore/Discover'),
        backgroundColor: Colors.grey.shade500,
      ),
      body: StreamBuilder<QuerySnapshot>(
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
            padding: EdgeInsets.all(16.0),
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
              final details = artwork['details'];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/artwork_details',
                    arguments: {'imageUrl': imageUrl, 'details': details},
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(imageUrl, height: 100, fit: BoxFit.cover),
                      SizedBox(height: 10),
                      Text(
                        details,
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
