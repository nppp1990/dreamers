import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/page/setting/block_list.dart';
import 'package:dreamer/page/setting/widgets.dart';
import 'package:flutter/material.dart';

class PrivacySettingItem extends StatelessWidget {
  const PrivacySettingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      name: 'Privacy',
      svgIcon: 'assets/images/icons/ic_privacy.svg',
      hasArrow: true,
      onTap: () {
        Navigator.of(context).push(Right2LeftRouter(child: const PrivacyPage()));
      },
    );
  }
}

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: 'Privacy',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Column(
          children: [
            SettingCheckItem(name: 'Block mobile contacts', checked: true, onChanged: (checked) {}),
            SettingItem2(name: 'Blocklist', onTap: () {
              Navigator.of(context).push(Right2LeftRouter(child: const BlockListPage()));
            }),
          ],
        ),
      ),
    );
  }
}
