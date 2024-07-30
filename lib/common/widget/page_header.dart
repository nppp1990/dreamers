import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:flutter/material.dart';

/// Header with back button and title
/// padding top is the height of status bar
class NormalHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const NormalHeader({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: statusBarHeight),
      child: SizedBox(
        height: 36,
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  child: const Icon(
                    DreamerIcons.arrowLeft,
                    color: DreamerColors.primary,
                    size: 24,
                  ),
                  onTap: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      Navigator.pop(context);
                    }
                  }),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 16,
                    height: 20 / 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
