import 'dart:io';

import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/constants/colors.dart';
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
              const _SettingModule(label: 'VIP', child: _SettingItem(name: 'Subscription')),
              const SizedBox(height: 24),
              const _SettingModule(
                  label: 'Account',
                  child: Column(
                    children: [
                      _SettingItem(
                        name: 'Email',
                        svgIcon: 'assets/images/icons/ic_email.svg',
                        hasArrow: true,
                      ),
                      SizedBox(height: 8),
                      _SettingItem(name: 'Password', svgIcon: 'assets/images/icons/ic_lock.svg', hasArrow: true),
                      SizedBox(height: 8),
                      _SettingItem(name: 'Phone Number', svgIcon: 'assets/images/icons/ic_phone.svg', hasArrow: true),
                      SizedBox(height: 8),
                      _SettingItem(
                          name: 'Language',
                          value: 'English',
                          svgIcon: 'assets/images/icons/ic_language.svg',
                          hasArrow: true),
                      SizedBox(height: 8),
                      _SettingItem(
                          name: 'Notification', svgIcon: 'assets/images/icons/ic_notification.svg', hasArrow: true),
                      SizedBox(height: 8),
                      _SettingItem(name: 'Privacy', svgIcon: 'assets/images/icons/ic_privacy.svg', hasArrow: true),
                    ],
                  )),
              const SizedBox(height: 24),
              _SettingModule(
                label: 'About',
                child: Column(
                  children: [
                    const _SettingItem(name: 'Help Center'),
                    const SizedBox(height: 8),
                    const _SettingItem(name: 'Term of use'),
                    const SizedBox(height: 8),
                    const _SettingItem(name: 'Privacy Policy'),
                    const SizedBox(height: 8),
                    _SettingItem(
                      name: 'Dreamer for ${Platform.isIOS ? 'IOS' : 'Android'}',
                      // todo dynamic version
                      value: 'v1.0.0',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _SettingCard(
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
        _SettingCard(child: child),
      ],
    );
  }
}

class _SettingCard extends StatelessWidget {
  final Widget child;

  const _SettingCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String name;
  final String? value;
  final String? svgIcon;
  final VoidCallback? onTap;
  final bool hasArrow;

  const _SettingItem({
    required this.name,
    this.value,
    this.svgIcon,
    this.onTap,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            if (svgIcon != null) ...[
              SvgPicture.asset(
                svgIcon!,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  DreamerColors.grey600,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  height: 18 / 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            if (value != null) ...[
              const SizedBox(width: 8),
              Text(
                value!,
                style: const TextStyle(
                  fontSize: 15,
                  height: 18 / 15,
                  fontWeight: FontWeight.w400,
                  color: DreamerColors.grey600,
                ),
              ),
            ],
            if (hasArrow) ...[
              SvgPicture.asset(
                'assets/images/icons/ic_arrow_right.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  DreamerColors.grey600,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ]),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: DreamerColors.divider2,
        ),
      ],
    );
  }
}
