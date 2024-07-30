import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:flutter/material.dart';

class EditHeader extends StatelessWidget {
  final String title;
  final String btnStr;
  final VoidCallback onDone;
  final VoidCallback? onBack;

  const EditHeader({super.key, required this.title, required this.btnStr, required this.onDone, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 63,
                height: 22,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: DreamerColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: onDone,
                  child: Text(
                    btnStr,
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
            ),
          ],
        ),
      ),
    );
  }
}
