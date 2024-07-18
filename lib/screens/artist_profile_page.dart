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
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(4, (index) 
                {
                  return Card(
                    child: Image.network('https://via.placeholder.com/150'),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
