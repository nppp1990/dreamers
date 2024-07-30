import 'dart:io';

import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/signup/onboarding.dart';
import 'package:dreamer/page/signup/onboarding_done.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Signup7 extends StatelessWidget {
  const Signup7({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
        step: 7,
        title: titleList[6],
        subTitle: subTitleList[6],
        onNext: () {
          Navigator.of(context).push(Right2LeftRouter(child: const SignupDonePage()));
        },
        child: const Padding(
          padding: EdgeInsets.only(top: 40),
          child: PicturePicker(),
        ));
  }
}

class PicturePicker extends StatefulWidget {
  const PicturePicker({super.key});

  @override
  State<StatefulWidget> createState() => _PicturePickerState();
}

class _PicturePickerState extends State<PicturePicker> {
  File? _image;

  _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: _pickImage,
          child: Container(
            // 圆形
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                color: DreamerColors.grey300,
                borderRadius: BorderRadius.circular(60),
                image: _image != null ? DecorationImage(image: FileImage(_image!), fit: BoxFit.cover) : null),
            child: _image == null
                ? const Center(
                    child: Icon(DreamerIcons.camera, size: 32, color: Colors.white),
                  )
                : null,
          ),
        ));
  }
}
