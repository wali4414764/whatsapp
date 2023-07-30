import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePictureWidget extends StatefulWidget {
  final void Function(File? profileImage) onProfileImageChanged;

  ProfilePictureWidget({required this.onProfileImageChanged});

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  File? _profileImage;

  void _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        widget.onProfileImageChanged(_profileImage);
      });
    }
  }

  void _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        widget.onProfileImageChanged(_profileImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Choose Profile Picture'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Take a new picture'),
                    onTap: () {
                      _openCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('Choose from gallery'),
                    onTap: () {
                      _openGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
        backgroundColor: _profileImage == null ? Colors.green : null,
        child: _profileImage == null
            ? Icon(
          Icons.person,
          size: 90,
        )
            : null,
      ),
    );
  }
}
