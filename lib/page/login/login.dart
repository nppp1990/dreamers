import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/common/widget/dash.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/login/signup.dart';
import 'package:dreamer/page/login/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                      fontFamily: 'SF Pro Text',
                      fontSize: 32,
                      height: 38 / 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // todo 这个文案Label么？
                const Text('Label',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 12,
                      height: 14.4 / 12,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(height: 4),
                NameTextField(onChanged: (value) {}),
                const SizedBox(height: 16),
                const Text('Password',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 12,
                      height: 14.4 / 12,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(height: 4),
                PasswordTextField(
                  onChanged: (value) {},
                ),
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget password?',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 12,
                      color: Color(DreamerColors.grey800),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                LoginButton(text: 'Login', onPressed: (){}),
                const SizedBox(height: 8),
                // 注册
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, Right2LeftRouter(child: const SignupPage()));
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
                            fontFamily: 'SF Pro Text',
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
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
                    color: Color(0xFFB5B5B5),
                  ),
                ),
                const SizedBox(height: 24),
                // sign in with google
                AuthLogin(text: 'Sign in with Google', svgName: 'assets/images/icons/ic_google.svg', onPressed: (){}),
                const SizedBox(height: 12),
                // sign in with apple
                AuthLogin(text: 'Sign in with Apple', svgName: 'assets/images/icons/ic_apple.svg', onPressed: (){}),
              ],
            ),
          ),
        ));
  }
}
