import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/check_util.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/data/provider/signup_data.dart';
import 'package:dreamer/page/signup/onboarding2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onboarding.dart';

/// enter phone number
class Signup1 extends StatelessWidget {
  const Signup1({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
        step: 1,
        title: titleList[0],
        subTitle: subTitleList[0],
        onNext: () {
          final signupData = Provider.of<SignupData>(context, listen: false);
          final prefix = signupData.phonePrefix;
          final phone = signupData.phoneNumber;
          var valid = CheckUtils.isPhoneNumberValid(prefix, phone);
          if (valid) {
            Navigator.of(context).push(Right2LeftRouter(child: const Signup2()));
          } else {
            DialogUtils.showToast(context, 'Invalid phone number');
          }
        },
        child: const _PhoneNumberEditView());
  }
}

class _PhoneNumberEditView extends StatefulWidget {
  const _PhoneNumberEditView();

  @override
  State<StatefulWidget> createState() => _PhoneNumberEditViewState();
}

class _PhoneNumberEditViewState extends State<_PhoneNumberEditView> {
  String _prefix = CheckUtils.prefixPhoneList[0];
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // dropDown button
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DreamerColors.secondary, width: 1),
          ),
          child: DropdownButton<String>(
            // width of DropdownButton depends on the maxWidth of the child
            value: _prefix,
            icon: const Icon(DreamerIcons.arrowDown, color: DreamerColors.grey600),
            // remove underline
            underline: Container(),
            iconSize: 24,
            onChanged: (value) {
              Provider.of<SignupData>(context, listen: false).setPhonePrefix(value!);
              setState(() {
                _prefix = value;
              });
            },
            items: CheckUtils.prefixPhoneList
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
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: NumberTextField(
            onChanged: (value) {
              _phone = value;
              Provider.of<SignupData>(context, listen: false).setPhoneNumber(value);
            },
          ),
        ),
      ],
    );
  }
}
