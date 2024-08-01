import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/setting/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordSettingItem extends StatelessWidget {
  const PasswordSettingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      name: 'Password',
      svgIcon: 'assets/images/icons/ic_lock.svg',
      hasArrow: true,
      onTap: () {
        Navigator.of(context).push(Right2LeftRouter(child: const PasswordPage()));
      },
    );
  }
}

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late String _newPassword;
  late String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: 'Change Password',
      rightBtnStr: 'Save',
      onRightBtn: () {
        // todo save password
        debugPrint('new password: $_newPassword, confirm password: $_confirmPassword');
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            EditCard(
              icon: SvgPicture.asset(
                'assets/images/icons/ic_lock2.svg',
                width: 20,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  DreamerColors.grey600,
                  BlendMode.srcIn,
                ),
              ),
              label: 'New Password',
              hintText: 'Please enter a new password',
              onChanged: (value) {
                _newPassword = value;
              },
            ),
            const SizedBox(height: 16),
            EditCard(
              icon: SvgPicture.asset(
                'assets/images/icons/ic_verify_code.svg',
                width: 18,
                height: 21,
                colorFilter: const ColorFilter.mode(
                  DreamerColors.grey600,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Confirm Password',
              hintText: 'Enter the new password again',
              onChanged: (value) {
                _confirmPassword = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                // todo forget password
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    fontSize: 16,
                    height: 19 / 16,
                    fontWeight: FontWeight.w400,
                    color: DreamerColors.primary,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
