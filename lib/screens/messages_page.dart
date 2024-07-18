import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: Colors.grey.shade500,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (context, index) 
        {
          return ListTile(
            title: Text('Message chat'),
          );
        },
      ),
    );
  }
}
