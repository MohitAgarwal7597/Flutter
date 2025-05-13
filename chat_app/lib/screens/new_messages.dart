import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});
  @override
  State<NewMessages> createState() {
    return _NewMessagesState();
  }
}

class _NewMessagesState extends State<NewMessages> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _messageController = TextEditingController();
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final message = _messageController.text;
    if (message.trim().isEmpty) {
      return;
    }
    // FirebaseFire
    FocusScope.of(context).unfocus();
    _messageController.clear();
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'userImage': userData.data()!['image_url'],
      'text': message,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()!['username'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 20, right: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.green),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                controller: _messageController,
                decoration: const InputDecoration(
                    hintText: 'Send a message..', border: InputBorder.none),
              ),
            ),
          ),
          IconButton(
              onPressed: _submitMessage,
              icon: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.green),
                child: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
              ))
        ],
      ),
    );
  }
}
