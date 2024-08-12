import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/check_util.dart';
import 'package:dreamer/common/utils/dialog_utils.dart';
import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/page/login/login.dart';
import 'package:dreamer/page/login/widgets.dart';
import 'package:flutter/material.dart';

class ResetEmailPage extends StatefulWidget {
  const ResetEmailPage({super.key});

  @override
  State<StatefulWidget> createState() => _ResetEmailPageState();
}

class _ResetEmailPageState extends State<ResetEmailPage> {
  late LabelTextFieldController _emailController;
  late ValueNotifier<bool> _isSendLoading;

  @override
  void initState() {
    super.initState();
    _emailController = LabelTextFieldController('');
    _isSendLoading = ValueNotifier(false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _isSendLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 44,
            ),
            const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 32,
                height: 38 / 32,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            LabelTextField(
              label: 'Email',
              hintText: 'Enter your email',
              valueCheck: _emailCheck,
              controller: _emailController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 16,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isSendLoading,
              builder: (BuildContext context, bool value, Widget? child) {
                return LoginButton(
                  isLoading: value,
                  text: 'Send verification code',
                  onPressed: () {
                    _onClickSend(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _emailCheck(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!CheckUtils.isEmail(value)) {
      return 'Email is invalid. Enter correctly.';
    }
    return '';
  }

  _onClickSend(BuildContext context) async {
    _emailController.error = _emailCheck(_emailController.textValue);
    if (_emailController.error.isNotEmpty) {
      return;
    }
    _isSendLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    _isSendLoading.value = false;
    if (context.mounted) {
      Navigator.of(context).push(Right2LeftRouter(child: const VerifyCodePage()));
    }
  }
}

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<StatefulWidget> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  late LabelTextFieldController _codeController;
  late ValueNotifier<bool> _isVerifyLoading;

  @override
  void initState() {
    super.initState();
    _codeController = LabelTextFieldController('');
    _isVerifyLoading = ValueNotifier(false);
  }

  @override
  void dispose() {
    _codeController.dispose();
    _isVerifyLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 44,
            ),
            const Text(
              'Verify code',
              style: TextStyle(
                fontSize: 32,
                height: 38 / 32,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            LabelTextField(
              label: 'Verification code',
              hintText: 'Verification code',
              controller: _codeController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 16,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isVerifyLoading,
              builder: (BuildContext context, bool value, Widget? child) {
                return LoginButton(
                  isLoading: value,
                  text: 'Verify',
                  onPressed: () {
                    _onClickVerify(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _onClickVerify(BuildContext context) async {
    if (_codeController.textValue.isEmpty) {
      DialogUtils.showToast(context, 'Verification code is empty');
      return;
    }
    _isVerifyLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    _isVerifyLoading.value = false;
    if (context.mounted) {
      Navigator.of(context).push(Right2LeftRouter(child: const ResetPasswordPage()));
    }
  }
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  late LabelTextFieldController _passwordController;
  late LabelTextFieldController _confirmPasswordController;
  late ValueNotifier<bool> _isResetLoading;

  @override
  void initState() {
    super.initState();
    _passwordController = LabelTextFieldController('');
    _confirmPasswordController = LabelTextFieldController('');
    _isResetLoading = ValueNotifier(false);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _isResetLoading.dispose();
    super.dispose();
  }

  String _passwordCheck(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (!CheckUtils.isPasswordValid(value)) {
      return 'Password should be 8 to 30 characters, including symbols and alphanumeric characters.';
    }
    return '';
  }

  String _confirmPasswordCheck(String value) {
    if (value.isEmpty) {
      return 'Password confirmation is required';
    }
    if (value != _passwordController.textValue) {
      return 'Password does not match';
    }
    return '';
  }


  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 44,
            ),
            const Text(
              'Set new password',
              style: TextStyle(
                fontSize: 32,
                height: 38 / 32,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            LabelTextField(
              label: 'Password',
              hintText: 'Enter your password',
              isPassword: true,
              valueCheck: _passwordCheck,
              controller: _passwordController,
            ),
            const SizedBox(
              height: 16,
            ),
            LabelTextField(
              label: 'Password (Confirm)',
              hintText: 'Confirm your password',
              isPassword: true,
              valueCheck: _confirmPasswordCheck,
              controller: _confirmPasswordController,
            ),
            const SizedBox(
              height: 16,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isResetLoading,
              builder: (BuildContext context, bool value, Widget? child) {
                return LoginButton(
                  isLoading: value,
                  text: 'Send verification code',
                  onPressed: () {
                    _onClickReset(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _onClickReset(BuildContext context) async {
    _passwordController.error = _passwordCheck(_passwordController.textValue);
    _confirmPasswordController.error = _confirmPasswordCheck(_confirmPasswordController.textValue);
    if (_passwordController.error.isNotEmpty || _confirmPasswordController.error.isNotEmpty) {
      return;
    }
    _isResetLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    _isResetLoading.value = false;
    if (context.mounted) {
      debugPrint('Reset password success');
      DialogUtils.showToast(context, 'Reset password success');
      // back to LoginPage
      Navigator.of(context).popUntil((route){
        if (route is Right2LeftRouter) {
          var child = route.child;
          debugPrint('child: $child');
          if (child is LoginPage) {
            debugPrint('----------------LoginPage is first');
            return true;
          }
        }
        return route.isFirst;
      });
      // Navigator.of(context).push(Right2LeftRouter(child: const ResetSuccessPage()));
    }
  }

}

