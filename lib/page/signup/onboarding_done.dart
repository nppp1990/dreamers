import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';

class SignupDonePage extends StatelessWidget {
  const SignupDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 24,
      height: 28 / 24,
      fontWeight: FontWeight.w700,
      color: DreamerColors.primary,
    );
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'It’s all done!',
                style: textStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
              const Text(
                'Now you can view your profile',
                style: textStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 35,
                width: 140,
                child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 0)),
                      backgroundColor: WidgetStateProperty.all(DreamerColors.primary),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    child: const Text(
                      'View Profile',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
