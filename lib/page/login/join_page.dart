import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/login/login.dart';
import 'package:dreamer/page/splash/dreamer_icon_text.dart';
import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        children: [
          const SizedBox(height: 128),
          const DreamerIconText(color: Colors.black),
          const SizedBox(height: 100),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Find a suitable partner in dreams',
              maxLines: null,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: 38,
                height: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('You are about to have dream where you feel special and one who is perfect for you will come along soon!',
                    maxLines: null,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 16,
                      height: 21 / 16,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                _gotoLogin(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 17),
                minimumSize: const Size(double.infinity, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: DreamerColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Join now',
                style: TextStyle(
                  fontSize: 18,
                  height: 21.5 / 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _gotoLogin(context);
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
                  'Already have account? ',
                  style: TextStyle(
                    fontSize: 15,
                    height: 20 / 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 15,
                    height: 20 / 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  void _gotoLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(Right2LeftRouter(child: const LoginPage()));
  }
}
