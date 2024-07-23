import 'package:artfolio/components/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget 
{
  UserPage({super.key});

  // current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // future for user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async 
  {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade500,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) 
        {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) 
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // error
          else if (snapshot.hasError) 
          {
            return Text("Error: ${snapshot.error}");
          }

          // data
          else if (snapshot.hasData) 
          {
            Map<String, dynamic>? user = snapshot.data!.data();

            return Column(
              children: [
                Text(user!['email']),
                Text(user['username']),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('artworks')
                        .where('userId', isEqualTo: currentUser!.uid)
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

                          return Card(
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
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } 
          else 
          {
            return Text("No data");
          }
        },
      ),
    );
  }
}
