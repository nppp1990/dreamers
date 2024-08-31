import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/common/widget/page_header.dart';
import 'package:flutter/material.dart';

class NormalPage extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback? onBack;
  final AssetImage assetImage;
  final String? rightBtnStr;
  final VoidCallback? onRightBtn;
  final bool bottomPadding;

  const NormalPage({
    super.key,
    required this.title,
    this.onBack,
    this.assetImage = const AssetImage('assets/images/bg_base1.png'),
    this.rightBtnStr,
    this.onRightBtn,
    this.bottomPadding = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      assetImage: assetImage,
      child: Column(
        children: [
          NormalHeader(title: title, onBack: onBack, rightBtnStr: rightBtnStr, onRightBtn: onRightBtn),
          Expanded(child: child),
          if (bottomPadding) SizedBox(height: MediaQuery.viewPaddingOf(context).bottom),
        ],
      ),
    );
  }
}
