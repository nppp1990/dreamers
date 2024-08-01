import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/page/splash/dreamer_icon_text.dart';
import 'package:flutter/material.dart';

class JoinNowPage extends StatelessWidget {
  const JoinNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageBackground(
      assetImage: AssetImage('assets/images/bg_join_now.png'),
      child: Column(
        children: [
          SizedBox(height: 180),
          DreamerIconText(color: Colors.white),
        ],
      ),
    );
  }
}
