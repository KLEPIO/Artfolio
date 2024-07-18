import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // logout user
  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      // navigate to login screen
      Navigator.of(context).pushReplacementNamed('/login_register_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // can add bg color here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header
              DrawerHeader(
                child: Icon(
                  Icons.palette,
                  color: Colors.grey.shade400,
                ),
              ),

              const SizedBox(height: 25),

              // user
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.grey.shade400,
                  ),
                  title: const Text("USER"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to user page
                    Navigator.pushNamed(context, '/user_page');
                  },
                ),
              ),

              // home
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.grey.shade400,
                  ),
                  title: const Text("HOME"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to home page
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ),

              // explore
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Colors.grey.shade400,
                  ),
                  title: const Text("EXPLORE"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to explore page
                    Navigator.pushNamed(context, '/explore_discover');
                  },
                ),
              ),

              // artist profile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.grey.shade400,
                  ),
                  title: const Text("ARTIST PROFILE"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to artist profile page
                    Navigator.pushNamed(context, '/artist_profile');
                  },
                ),
              ),

              // artwork details
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.image,
                    color: Colors.grey.shade400,
                  ),
                  title: const Text("ARTWORK DETAILS"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to artwork details page
                    Navigator.pushNamed(context, '/artwork_details');
                  },
                ),
              ),

              // upload artwork
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.upload,
                    color: Colors.grey.shade400,
                  ),
                  title: const Text("UPLOAD ARTWORK"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to upload artwork page
                    Navigator.pushNamed(context, '/upload_artwork');
                  },
                ),
              ),

              // messages
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.message,
                    color: Colors.grey.shade400,
                  ),
                  title: const Text("MESSAGES"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to messages page
                    Navigator.pushNamed(context, '/messages');
                  },
                ),
              ),
            ],
          ),

          // logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.grey.shade400,
              ),
              title: const Text("LOGOUT"),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // logout user
                logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
