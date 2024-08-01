import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/provider/signup_data.dart';
import 'package:dreamer/page/signup/onboarding3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onboarding.dart';

class Signup2 extends StatefulWidget {
  const Signup2({super.key});

  @override
  State<StatefulWidget> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  String _code = '';
  bool _hasSend = false;

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
      step: 2,
      title: titleList[1],
      subTitle: subTitleList[1],
      onNext: () {
        final phoneNumber = Provider.of<SignupData>(context, listen: false).phoneNumber;
        // todo check verification code
        // if (_value == preNumber) {
        Navigator.of(context).push(Right2LeftRouter(child: const Signup3()));
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('two phone number is not the same'),
        //   ));
        // }
      },
      child: Column(
        children: [
          NumberTextField(onChanged: (value) {
            _code = value;
          }),
          const SizedBox(height: 12),
          // TextButton 有下划线
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: _reSendCode,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Resend code',
                      style: TextStyle(
                          fontSize: 12,
                          height: 14 / 12,
                          color: DreamerColors.grey800,
                          decoration: TextDecoration.underline))),
              const SizedBox(width: 6),
              if (_hasSend) Image.asset('assets/images/icons/ic_checked.png', width: 15, height: 15),
            ],
          ),
        ],
      ),
    );
  }

  _reSendCode() {
    // todo send code
    setState(() {
      _hasSend = true;
    });
  }
}