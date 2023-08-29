import 'package:chatlyapp/bloc/auth_event.dart';
import 'package:chatlyapp/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign User Out
  void signOut() {
    context.read<AuthBloc>().add(SignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff091228),
      appBar: AppBar(
        backgroundColor: const Color(0xff091228),
        elevation: 0,
        leading: Image.asset(
          'lib/assets/mmlogo.png',
          width: 100,
          height: 100,
        ),
        actions: [
         IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: _buildUserList(),
    );
  }

  // Build List of Users
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState ==  ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  // build userlist items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email'], style: const TextStyle(color: Colors.white),),
        onTap: () {
          // pass the clicked user's UID to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
