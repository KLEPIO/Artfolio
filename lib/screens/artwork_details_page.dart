import 'package:flutter/material.dart';

class ArtworkDetailsPage extends StatelessWidget 
{
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
            Image.network('https://via.placeholder.com/300'),
            SizedBox(height: 10),
            Text(
              'Information about the image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('This is a description of the artwork.'),
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
