import 'dart:io';

import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/provider/signup_data.dart';
import 'package:dreamer/page/signup/onboarding7.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onboarding.dart';

class Signup6 extends StatefulWidget {
  const Signup6({super.key});

  @override
  State<StatefulWidget> createState() => _Signup6State();
}

class _Signup6State extends State<Signup6> {
  DateTime? _birthday;

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
      step: 6,
      title: titleList[5],
      subTitle: subTitleList[5],
      onNext: () {
        if (_birthday == null) {
          DialogUtils.showToast(context, 'Please select your birthday');
          return;
        }
        Provider.of<SignupData>(context, listen: false).setBirthday(_birthday!.millisecondsSinceEpoch);
        Navigator.of(context).push(Right2LeftRouter(child: const Signup7()));
        // if (_value.isNotEmpty) {
        //   // Navigator.of(context).push(Right2LeftRouter(child: const Signup4()));
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('birthdate cannot be empty'),
        //   ));
        // }
      },
      child: DatePickerTextField(onChanged: (value) {
        _birthday = value;
      }),
    );
  }
}

class DatePickerTextField extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;

  const DatePickerTextField({super.key, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Platform.isIOS) {
          showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (value) {
                    setState(() {
                      _value = value.toString().split(' ')[0];
                    });
                    widget.onChanged(value);
                  },
                ),
              );
            },
          );
        } else {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then((value) {
            if (value != null) {
              setState(() {
                _value = value.toString().split(' ')[0];
              });
              widget.onChanged(value);
            }
          });
        }
      },
      child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DreamerColors.secondary, width: 1),
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                _value.isEmpty ? 'Select your birthday' : _value.toString(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  height: 1,
                  color: _value.isEmpty ? Colors.grey : Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              )),
              Image.asset('assets/images/icons/ic_calendar.png', width: 24, height: 24),
            ],
          )),
    );
  }
}
