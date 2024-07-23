import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget 
{
  const AppDrawer({super.key});

  void logout(BuildContext context) 
  {
    FirebaseAuth.instance.signOut().then((_) 
    {
      Navigator.of(context).pushReplacementNamed('/login_register_page');
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.palette,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 25),
              // explore
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Colors.grey.shade400,
                  ),
                  title: const Text("EXPLORE"),
                  onTap: () 
                  {
                    Navigator.pop(context);
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
                  onTap: () 
                  {
                    Navigator.pop(context);
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
                  onTap: () 
                  {
                    Navigator.pop(context);
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
                  onTap: () 
                  {
                    Navigator.pop(context);
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
                  onTap: () 
                  {
                    Navigator.pop(context);
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
              onTap: () 
              {
                Navigator.pop(context);
                logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
