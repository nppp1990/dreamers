import 'dart:io';

import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/profile_detail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/edit_header.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: [
            EditHeader(
              title: 'Edit Profile',
              btnStr: 'Done',
              onDone: () {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _EditPhoto(),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: const ProfileDetailEdit(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditPhoto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<_EditPhoto> {
  File? _image;
  static const testUrl = 'https://img.aigexing.com/uploads/9/1253/3315803060/92902931067/61746198.jpg';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
            child: GestureDetector(
          onTap: _pickImage,
          child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: _image == null ? const NetworkImage(testUrl) : FileImage(_image!),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Icon(DreamerIcons.camera, size: 24, color: Colors.white),
              )),
        )));
  }

  _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
