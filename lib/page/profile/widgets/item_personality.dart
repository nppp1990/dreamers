import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/profile/edit_pages/edit_labels_page.dart';
import 'package:dreamer/page/profile/widgets/base_detail_item.dart';
import 'package:flutter/material.dart';

class PersonalityItem extends StatelessWidget with BaseDetailItemMixin {
  final List<String> value;
  final bool isEdit;
  final ValueChanged<List<String>>? onChanged;

  const PersonalityItem({super.key, required this.value, this.isEdit = false, this.onChanged});

  @override
  bool get edit => isEdit;

  @override
  String get title => 'Personality';

  @override
  Widget buildChild(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: value.map((e) => _LabelItem(label: e)).toList(),
    );
  }

  @override
  void onTap(BuildContext context) {
    // TODO: implement onTap
    Navigator.of(context).push(Right2LeftRouter(child: EditLabelsPage(title: title)));
  }
}

class _LabelItem extends StatelessWidget {
  final String label;

  const _LabelItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: DreamerColors.secondary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          height: 14 / 12,
          fontWeight: FontWeight.w500,
          color: DreamerColors.primary,
        ),
      ),
    );
  }
}
