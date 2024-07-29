import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/profile/widgets/base_detail_item.dart';
import 'package:flutter/material.dart';

class AboutItem extends StatelessWidget with BaseDetailItemMixin {
  final String value;
  final bool isEdit;
  final ValueChanged<String>? onChanged;

  const AboutItem({super.key, required this.value, this.isEdit = false, this.onChanged});

  @override
  bool get edit => isEdit;

  @override
  get onTap => () {
    // todo: show edit dialog
  };

  @override
  get title => 'About';

  @override
  Widget buildChild(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 15,
        height: 18 / 15,
        fontWeight: FontWeight.w400,
        color: Color(DreamerColors.grey600),
      ),
    );
  }

}
