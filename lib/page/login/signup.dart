import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/check_util.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/common/widget/dash.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/login/widgets.dart';
import 'package:dreamer/page/signup/onboarding.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final LabelTextFieldController _emailController = LabelTextFieldController('');
  final LabelTextFieldController _passwordController = LabelTextFieldController('');
  final LabelTextFieldController _confirmPasswordController = LabelTextFieldController('');

  String _emailCheck(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!CheckUtils.isEmail(value)) {
      return 'Email is invalid. Enter correctly.';
    }
    return '';
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
    return PageBackground(
        assetImage: const AssetImage('assets/images/bg_base1.png'),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    height: 116,
                  ),
                  const Center(
                    child: Text(
                      'Welcome to\n Dreamer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        height: 38 / 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  LabelTextField(
                    label: 'Email',
                    hintText: 'Enter your email',
                    valueCheck: _emailCheck,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  LabelTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    isPassword: true,
                    valueCheck: _passwordCheck,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 16),
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
                  LoginButton(
                    text: 'Sign up',
                    onPressed: () {
                      _onClickSignup(context);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    width: double.infinity,
                    child: DashedLine(
                      color: DreamerColors.divider,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // sign in with google
                  AuthLogin(
                      text: 'Sign in with Google', svgName: 'assets/images/icons/ic_google.svg', onPressed: () {}),
                  const SizedBox(height: 12),
                  // sign in with apple
                  AuthLogin(text: 'Sign in with Apple', svgName: 'assets/images/icons/ic_apple.svg', onPressed: () {}),
                ]))));
  }

  _onClickSignup(BuildContext context) {
    _emailController.error = _emailCheck(_emailController.textValue);
    _passwordController.error = _passwordCheck(_passwordController.textValue);
    _confirmPasswordController.error = _confirmPasswordCheck(_confirmPasswordController.textValue);
    // if (_emailController.error.isNotEmpty ||
    //     _passwordController.error.isNotEmpty ||
    //     _confirmPasswordController.error.isNotEmpty) {
    //   return;
    // }

    // todo test
    Navigator.push(context, Right2LeftRouter(child: const OnboardingPage()));
  }
}
