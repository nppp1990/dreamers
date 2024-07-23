import 'package:flutter/material.dart';

class DreamerIconText extends StatelessWidget {
  final Color color;

  const DreamerIconText({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage('assets/images/icons/dreamer.png')),
        const SizedBox(height: 8),
        Text(
          'Dreamer',
          style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
        ),
      ],
    );
  }
}
