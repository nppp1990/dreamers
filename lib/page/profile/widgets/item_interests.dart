import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/profile/widgets/base_detail_item.dart';
import 'package:flutter/material.dart';

class InterestsItem extends StatelessWidget with BaseDetailItemMixin {
  final List<String> value;
  final bool isEdit;
  final ValueChanged<List<String>>? onChanged;

  const InterestsItem({super.key, required this.value, this.isEdit = false, this.onChanged});

  @override
  bool get edit => isEdit;

  @override
  String get title => 'Interests';

  @override
  Widget buildChild(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: value.map((e) => _InterestItem(interest: e)).toList(),
    );
  }

  @override
  void onTap(BuildContext context) {
    // TODO: implement onTap
  }
}

class _InterestItem extends StatelessWidget {
  final String interest;

  const _InterestItem({required this.interest});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: DreamerColors.greyBorder,
          width: 1,
        ),
      ),
      child: Text(
        interest,
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 12,
          height: 14 / 12,
          fontWeight: FontWeight.w500,
          color: DreamerColors.grey600,
        ),
      ),
    );
  }
}
