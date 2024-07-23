import 'package:flutter/material.dart';

class ArtworkDetailsPage extends StatelessWidget 
{
  final String imageUrl;
  final String details;

  ArtworkDetailsPage({required this.imageUrl, required this.details});

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
            Image.network(imageUrl),
            SizedBox(height: 10),
            Text(
              'Information about the image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(details),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 10),
                Text('Leave a comment'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
