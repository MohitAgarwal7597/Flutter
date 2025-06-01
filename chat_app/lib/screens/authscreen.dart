import 'dart:io';

import 'package:chat_app/widgets/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  File? selectedImage;
  bool isLogin = true;
  var enteredEmail = '';
  var enteredUserName = '';
  var enteredPassword = '';
  final _form = GlobalKey<FormState>();
  void submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid || !isLogin && selectedImage == null) {
      print('Retured');
      return;
    }
    _form.currentState!.save();
    try {
      if (isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${userCredential.user!.uid}.jpg');
        await storageRef.putFile(selectedImage!);
        final imaegUrl = await storageRef.getDownloadURL();
        print('THIS IS THE IMAGE U  R  LL :  ${imaegUrl}');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': enteredUserName,
          'email': enteredEmail,
          'image_url': imaegUrl,
          'password': enteredPassword,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.message == 'email-already-in-use') {
        //..error code for email already in use.
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Auth Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text(
                'Do you want to exit the app?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                Container(
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
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
          return shouldPop ?? false;
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 30, left: 20, bottom: 20, right: 20),
                  width: 200,
                  child: Image.asset('assets/images/chat.png'),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isLogin)
                              UserImage(onPickedImage: (onSelectedImage) {
                                selectedImage = onSelectedImage;
                              }),
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Enter Email Address'),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please Enter A Valid Email Address';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                enteredEmail = value!;
                              },
                            ),
                            if (!isLogin)
                              TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 4) {
                                    return 'Please Enter Valid Name(atleast 4 character long)';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    // hintText: 'Enter Your Name',
                                    labelText: 'Enter Your Name'),
                                onSaved: (newValue) {
                                  enteredUserName = newValue!;
                                },
                              ),
                            TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                label: Text('Enter Password'),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Please enter atleast 6 digit length valid password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                enteredPassword = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                onPressed: submit,
                                child: Text(isLogin ? 'Login' : 'SignUp')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(isLogin
                                    ? 'Create an account'
                                    : 'I Already have an account! Login.'))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
