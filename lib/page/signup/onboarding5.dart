import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/signup/onboarding.dart';
import 'package:dreamer/page/signup/onboarding6.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

/// choose region
class Signup5 extends StatefulWidget {
  const Signup5({super.key});

  @override
  State<StatefulWidget> createState() => _Signup5PageState();
}

class _Signup5PageState extends State<Signup5> {
  static const List<String> genderList = [
    'Male',
    'Female',
    'Transgender',
    'Non-binary',
    'Genderqueer',
    'Genderfluid',
    'Intersex',
    'Queer',
    'Agender',
    'Bisexual',
  ];

  late String? _gender;
  late String? _gender2;

  @override
  void initState() {
    super.initState();
    _gender = genderList.first;
    _gender2 = null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> others;
    if (_gender == genderList[0] || _gender == genderList[1]) {
      others = [];
    } else {
      others = [
        const SizedBox(height: 32),
        const Text(
          'If you chose neither male or female, which gender are you looking for?',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          'Pickup a biological sex',
          style: TextStyle(
            fontSize: 12,
            height: 14 / 12,
            color: DreamerColors.grey800,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        DataSelector(
          value: _gender2,
          onChanged: (value) {
            setState(() {
              _gender2 = value;
            });
          },
          regionList: genderList,
        )
      ];
    }

    return SignupBasePage(
        step: 5,
        title: titleList[4],
        subTitle: subTitleList[4],
        onNext: () {
          // todo
          Navigator.of(context).push(Right2LeftRouter(child: const Signup6()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataSelector(
              value: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                  _gender2 = null;
                });
              },
              regionList: genderList,
            ),
            ...others,
          ],
        ));
  }
}

class RegionSelector extends StatelessWidget {
  final String? value;
  final String hint;
  final ValueChanged<String?> onChanged;
  final List<String> regionList;

  const RegionSelector(
      {super.key, required this.value, required this.hint, required this.onChanged, required this.regionList});

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      // width of DropdownButton depends on the maxWidth of the child
      value: value,
      hint: Text(
        hint,
        style: const TextStyle(
          fontSize: 16,
          height: 1,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(DreamerIcons.arrowDown, color: DreamerColors.grey600),
        iconSize: 24,
      ),
      // remove underline
      underline: Container(),
      buttonStyleData: ButtonStyleData(
        padding: const EdgeInsets.only(left: 16, right: 8),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: DreamerColors.secondary, width: 1),
        ),
        // backgroundColor: Colors.white,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(8),
        // ),
      ),

      isExpanded: true,
      onChanged: onChanged,
      items: regionList
          .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              )))
          .toList(),
    );
  }
}
