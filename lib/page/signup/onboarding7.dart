import 'dart:io';

import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/data/provider/signup_data.dart';
import 'package:dreamer/page/signup/onboarding.dart';
import 'package:dreamer/page/signup/onboarding_done.dart';
import 'package:dreamer/request/bean/user_profile.dart';
import 'package:dreamer/request/request_manager.dart';
import 'package:dreamer/service/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Signup7 extends StatelessWidget {
  const Signup7({super.key});

  _next(BuildContext context) async {
    SignupData data = Provider.of<SignupData>(context, listen: false);
    User user = User(id: UserManager().loginResult!.userId, phoneNumber: data.phoneNumber);
    ProfileInfo profileInfo = ProfileInfo(
      id: UserManager().loginResult!.userProfileId,
      user: user,
      nickname: data.nickname,
      livingCountry: data.country,
      livingState: data.state,
      genderIdentity: data.genderIdentity,
      targetGender: data.targetGender,
      birthday: data.birthday,
      // todo this is for test
      profileImage: 'https://pic1.zhimg.com/v2-d24a84ea4ea3e152f5eb035b736caf97_r.jpg',
    );
    final res = await RequestManager().updateProfile(profileInfo);
    if (res.data != null && res.data!.birthday != null) {
      UserManager().saveProfileComplete(true);
      if (context.mounted) {
        Navigator.of(context).push(Right2LeftRouter(child: const SignupDonePage()));
      }
    } else if (context.mounted) {
      DialogUtils.showToast(context, 'Failed to update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
        step: 7,
        title: titleList[6],
        subTitle: subTitleList[6],
        onNext: () => _next(context),
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
