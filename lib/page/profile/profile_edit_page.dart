import 'dart:io';

import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/profile_detail.dart';
import 'package:dreamer/request/bean/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/edit_header.dart';

class ProfileEditPage extends StatelessWidget {
  final ProfileInfo oldProfileInfo;
  final ProfileInfo newProfileInfo;

  const ProfileEditPage({super.key, required this.oldProfileInfo, required this.newProfileInfo});

  _handlePop(BuildContext context) async {
    if (oldProfileInfo.isDifferent(newProfileInfo)) {
      // Show a dialog to confirm changes
      final shouldSave = await DialogUtils.showConfirmationDialog(
        context,
        'Save changes?',
        'You have unsaved changes. Do you want to save them?',
      );
      if (!context.mounted) {
        return;
      }
      if (shouldSave) {
        // Save changes and pop with the new profile info
        Navigator.of(context).pop(newProfileInfo);
      } else {
        // Discard changes and pop without any result
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    debugPrint('-----ProfileEditPage.build-----');
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        debugPrint('-----ProfileEditPage.onPopInvokedWithResult: $didPop, $result-----');
        // if user call pop, this didPop will be true
        if (didPop) {
          return;
        }
        _handlePop(context);
      },
      child: PageBackground(
        assetImage: const AssetImage('assets/images/bg_base1.png'),
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            children: [
              EditHeader(
                title: 'Edit Profile',
                btnStr: 'Done',
                onDone: () {
                  if (oldProfileInfo.isDifferent(newProfileInfo)) {
                    Navigator.of(context).pop(newProfileInfo);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                onBack: () {
                  _handlePop(context);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _EditPhoto(
                        url: newProfileInfo.profileImage!,
                        onImageChanged: (path) {
                          debugPrint('-----ProfileEditPage.onImageChanged: $path-----');
                          // todo: update profile image
                          // newProfileInfo.profileImage = path;
                        },
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: ProfileDetailEdit(
                          profileInfo: newProfileInfo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditPhoto extends StatefulWidget {
  final String url;
  final ValueSetter<String> onImageChanged;

  const _EditPhoto({required this.url, required this.onImageChanged});

  @override
  State<StatefulWidget> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<_EditPhoto> {
  File? _image;

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
                  image: _image == null ? NetworkImage(widget.url) : FileImage(_image!),
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
    if (pickedFile != null && pickedFile.path != _image?.path) {
      setState(() {
        widget.onImageChanged(pickedFile.path);
        _image = File(pickedFile.path);
      });
    }
  }
}
