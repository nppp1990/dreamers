import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:flutter/material.dart';

/// Header with back button and title
/// padding top is the height of status bar
class NormalHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final String? rightBtnStr;
  final VoidCallback? onRightBtn;

  const NormalHeader({super.key, required this.title, this.onBack, this.rightBtnStr, this.onRightBtn});

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
            if (rightBtnStr != null && onRightBtn != null)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: DreamerColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: onRightBtn,
                  child: Text(
                    rightBtnStr!,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 12,
                      height: 14.3 / 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
