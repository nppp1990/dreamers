import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/signup/onboarding4.dart';
import 'package:flutter/material.dart';

import 'onboarding.dart';

class Signup3 extends StatefulWidget {
  const Signup3({super.key});

  @override
  State<StatefulWidget> createState() => _Signup3State();
}

class _Signup3State extends State<Signup3> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
      step: 3,
      title: titleList[2],
      subTitle: subTitleList[2],
      onNext: () {
        if (_value.isNotEmpty) {
          Navigator.of(context).push(Right2LeftRouter(child: const Signup4()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('nickname cannot be empty'),
          ));
        }
      },
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 16,
          height: 1,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: DreamerColors.secondary, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: DreamerColors.secondary, width: 1),
          ),
        ),
        onChanged: (value) {
          _value = value;
        },
      ),
    );
  }
}