import 'package:flutter/material.dart';

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
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: List.generate(10, (index) 
        {
          return Card(
            child: Image.network('https://via.placeholder.com/150'),
          );
        }),
      ),
    );
  }
}
