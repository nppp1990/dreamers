import 'dart:io';

import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/profile_detail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
            _EditHeader(onDone: () {}),
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

class _EditHeader extends StatelessWidget {
  final VoidCallback onDone;

  const _EditHeader({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 36,
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  child: const Icon(
                    DreamerIcons.arrowLeft,
                    color: Color(DreamerColors.primary),
                    size: 24,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Edit Profile',
                style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 16,
                    height: 20 / 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 63,
                height: 22,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: const Color(DreamerColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: onDone,
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 12,
                      height: 14.3 / 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
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
  static const testUrl1 = 'https://pics4.baidu.com/feed/aec379310a55b319bb896f647f3b152ecefc17cd.jpeg';
  static const testUrl2 = 'https://img.aigexing.com/uploads/9/1253/3315803060/92902931067/61746198.jpg';

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
                  image: _image == null ? NetworkImage(_getTestUrl()) : FileImage(_image!),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Icon(DreamerIcons.camera, size: 24, color: Colors.white),
              )),
        )));
  }

  String _getTestUrl() {
    return DateTime.now().millisecondsSinceEpoch % 2 == 0 ? testUrl1 : testUrl2;
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
