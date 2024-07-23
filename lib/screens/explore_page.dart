import 'package:artfolio/components/user_tile.dart';
import 'package:artfolio/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:artfolio/auth/auth.dart';
import 'package:artfolio/components/app_drawer.dart';
import 'package:artfolio/auth/chat_service.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthPage _authPage = AuthPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      drawer: AppDrawer(),
      body: _buildUserList(),
    );
  }

  // build list of users, except current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
              ),
            ));
      },
    );
  }
}
