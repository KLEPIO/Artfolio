import 'package:flutter/material.dart';
import 'package:artfolio/components/app_drawer.dart'; // Ensure this import

class HomePage extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.grey.shade500,
      ),
      drawer: AppDrawer(), // Ensure AppDrawer is correctly implemented
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          HomePageButton(
            title: 'Artist Profile',
            onTap: () 
            {
              Navigator.pushNamed(context, '/artist_profile');
            },
          ),
          HomePageButton(
            title: 'Explore/Discover',
            onTap: () 
            {
              Navigator.pushNamed(context, '/explore_discover');
            },
          ),
          HomePageButton(
            title: 'Upload Artwork',
            onTap: () 
            {
              Navigator.pushNamed(context, '/upload_artwork');
            },
          ),
          HomePageButton(
            title: 'Messaging',
            onTap: () 
            {
              Navigator.pushNamed(context, '/messages');
            },
          ),
        ],
      ),
    );
  }
}

class HomePageButton extends StatelessWidget 
{
  final String title;
  final Function() onTap;

  HomePageButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) 
  {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.purple.shade50,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
