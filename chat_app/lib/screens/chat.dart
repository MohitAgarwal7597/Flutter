import 'package:chat_app/screens/chat_messages.dart';
import 'package:chat_app/screens/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  State<ChatScreen> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Global Chats'),
          actions: [
            IconButton(
              onPressed: () async {
                bool confirmLogout = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Log Out'),
                    content: Text('Do you want to log out from this app?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirmLogout) {
                  await FirebaseAuth.instance.signOut();
                }
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: const Column(
          children: [Expanded(child: ChatMessages()), NewMessages()],
        ));
  }
}
