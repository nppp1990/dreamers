import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/profile/edit_pages/edit_single_page.dart';
import 'package:dreamer/page/profile/widgets/base_detail_item.dart';
import 'package:flutter/material.dart';

class AboutItem extends StatefulWidget {
  final String value;
  final bool isEdit;
  final ValueChanged<String>? onChanged;

  const AboutItem({super.key, required this.value, this.isEdit = false, this.onChanged});

  @override
  State<StatefulWidget> createState() => _AboutItemState();
}

class _AboutItemState extends State<AboutItem> with BaseDetailItemMixin {
  late String _value;

  @override
  bool get edit => widget.isEdit;

  @override
  get title => 'About';

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget buildChild(BuildContext context) {
    return Text(
      _value,
      style: const TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 15,
        height: 18 / 15,
        fontWeight: FontWeight.w400,
        color: DreamerColors.grey600,
      ),
    );
  }

  @override
  void onTap(BuildContext context) async {
    final res = await Navigator.of(context).push(Right2LeftRouter(
      child: EditSingleItemPage(title: 'About', oldValue: _value),
    ));
    if (res != null && res is String) {
      setState(() {
        _value = res;
        widget.onChanged?.call(res);
      });
    }
  }
}
