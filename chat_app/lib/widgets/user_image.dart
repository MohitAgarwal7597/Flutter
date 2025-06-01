import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImage extends StatefulWidget {
  const UserImage({super.key, required this.onPickedImage});
  final void Function(File onSelectedImage) onPickedImage;
  @override
  State<StatefulWidget> createState() {
    return UserImageState();
  }
}

class UserImageState extends State<UserImage> {
  File? pickedImage;
  void _pickImage() async {
    final userImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 150, imageQuality: 50);
    if (userImage == null) {
      return;
    }
    setState(() {
      pickedImage = File(userImage.path);
    });
    widget.onPickedImage(pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          foregroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Add Image'))
      ],
    );
  }
}
