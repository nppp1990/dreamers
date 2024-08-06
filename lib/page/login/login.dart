import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/utils/check_util.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/common/widget/dash.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/login/signup.dart';
import 'package:dreamer/page/login/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LabelTextFieldController _emailController = LabelTextFieldController('');
  final LabelTextFieldController _passwordController = LabelTextFieldController('');

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

  void onLogin() {
    debugPrint('Login: ${_emailController.textValue}');
    _emailController.error = _emailCheck(_emailController.textValue);
    _passwordController.error = _passwordCheck(_passwordController.textValue);
  }

  @override
  Widget build(BuildContext context) {
    return PageBackground(
        assetImage: const AssetImage('assets/images/bg_base1.png'),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget password?',
                    style: TextStyle(
                      fontSize: 12,
                      color: DreamerColors.grey800,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                LoginButton(
                  text: 'Login',
                  onPressed: onLogin,
                ),
                const SizedBox(height: 8),
                // 注册
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, Right2LeftRouter(child: SignupPage()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Sign up',
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
                // 虚线
                const SizedBox(height: 16),
                const SizedBox(
                  width: double.infinity,
                  child: DashedLine(
                    color: DreamerColors.divider,
                  ),
                ),
                const SizedBox(height: 24),
                // sign in with google
                AuthLogin(text: 'Sign in with Google', svgName: 'assets/images/icons/ic_google.svg', onPressed: () {}),
                const SizedBox(height: 12),
                // sign in with apple
                AuthLogin(text: 'Sign in with Apple', svgName: 'assets/images/icons/ic_apple.svg', onPressed: () {}),
              ],
            ),
          ),
        ));
  }
}
