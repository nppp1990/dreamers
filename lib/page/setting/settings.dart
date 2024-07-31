import 'dart:io';

import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/setting/email.dart';
import 'package:dreamer/page/setting/password.dart';
import 'package:dreamer/page/setting/phone.dart';
import 'package:dreamer/page/setting/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: 'Settings',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              const _SettingModule(
                  label: 'VIP',
                  child: SettingItem(
                    name: 'Subscription',
                    svgIcon: 'assets/images/icons/ic_card.svg',
                    value: 'Premium',
                  )),
              const SizedBox(height: 24),
              const _SettingModule(
                  label: 'Account',
                  child: Column(
                    children: [
                      EmailSettingItem(),
                      SizedBox(height: 8),
                      PasswordSettingItem(),
                      SizedBox(height: 8),
                      PhoneSettingItem(),
                      SizedBox(height: 8),
                      SettingItem(
                          name: 'Language',
                          value: 'English',
                          svgIcon: 'assets/images/icons/ic_language.svg',
                          hasArrow: true),
                      SizedBox(height: 8),
                      SettingItem(
                          name: 'Notification', svgIcon: 'assets/images/icons/ic_notification.svg', hasArrow: true),
                      SizedBox(height: 8),
                      SettingItem(name: 'Privacy', svgIcon: 'assets/images/icons/ic_privacy.svg', hasArrow: true),
                    ],
                  )),
              const SizedBox(height: 24),
              _SettingModule(
                label: 'About',
                child: Column(
                  children: [
                    const SettingItem(name: 'Help Center'),
                    const SizedBox(height: 8),
                    const SettingItem(name: 'Term of use'),
                    const SizedBox(height: 8),
                    const SettingItem(name: 'Privacy Policy'),
                    const SizedBox(height: 8),
                    SettingItem(
                      name: 'Dreamer for ${Platform.isIOS ? 'IOS' : 'Android'}',
                      // todo dynamic version
                      value: 'v1.0.0',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SettingCard(
                  child: SizedBox(
                height: 32,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/ic_exit.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        DreamerColors.danger,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Sign out',
                        style: TextStyle(
                          fontSize: 15,
                          height: 18 / 15,
                          fontWeight: FontWeight.w400,
                          color: DreamerColors.danger,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingModule extends StatelessWidget {
  final String label;
  final Widget child;

  const _SettingModule({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SettingCard(child: child),
      ],
    );
  }
}
