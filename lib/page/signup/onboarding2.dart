import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/provider/signup_data.dart';
import 'package:dreamer/page/signup/onboarding3.dart';
import 'package:dreamer/request/request_manager.dart';
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
  bool _isVerifying = false;
  bool _isSendingCode = false;

  @override
  void initState() {
    super.initState();
    _sendCode();
  }

  _sendCode() {
    final signupData = Provider.of<SignupData>(context, listen: false);
    final prefix = signupData.phonePrefix!;
    final phoneNumber = signupData.phoneNumber!;
    RequestManager().sendCodeToPhone(prefix, phoneNumber);
  }

  _next(BuildContext context) async {
    if (_code.isEmpty) {
      DialogUtils.showToast(context, 'Please enter verification code');
      return;
    }
    if (_isVerifying) {
      debugPrint('can not go next page: is verifying');
      return;
    }
    _isVerifying = true;
    final res = await RequestManager().checkCode(_code);
    _isVerifying = false;
    if (!context.mounted) {
      return;
    }
    if (res.data?.isSuccess) {
      Navigator.of(context).push(Right2LeftRouter(child: const Signup3()));
    } else {
      DialogUtils.showToast(context, 'Failed to verify code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignupBasePage(
      step: 2,
      title: titleList[1],
      subTitle: subTitleList[1],
      onNext: () {
        _next(context);
      },
      child: Column(
        children: [
          NumberTextField(onChanged: (value) {
            _code = value;
          }),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    _reSendCode(context);
                  },
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

  _reSendCode(BuildContext context) async {
    if (_isSendingCode) {
      return;
    }
    final signupData = Provider.of<SignupData>(context, listen: false);
    final prefix = signupData.phonePrefix!;
    final phoneNumber = signupData.phoneNumber!;
    _isSendingCode = true;
    final res = await RequestManager().sendCodeToPhone(prefix, phoneNumber);
    _isSendingCode = false;
    if (res.data?.isSuccess) {
      setState(() {
        _hasSend = true;
      });
    } else {
      if (context.mounted) {
        DialogUtils.showToast(context, 'Failed to resend code');
      }
    }
  }
}
