import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/edit_pages/edit_multi_select_page.dart';
import 'package:dreamer/page/profile/edit_pages/edit_single_page.dart';
import 'package:dreamer/page/profile/edit_pages/edit_single_select_dialog.dart';
import 'package:dreamer/page/profile/edit_pages/edit_two_select_page.dart';
import 'package:dreamer/page/profile/widgets/base_detail_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Basic information item
/// [key] is the title of the information
/// [value] is the content of the information
/// [type] is the type of the information, default is [BasicType.right]
class BasicInfoBean {
  final BasicInfoKey key;
  final Object value;
  final BasicType type;

  BasicInfoBean({required this.key, required this.value, required this.type});
}

enum BasicInfoKey {
  nickName,
  age,
  language,
  living,
  education,
  occupation,
  height,
  bodyType,
  marital,
  relationshipGoal,
  test1,
  test2,
}

extension BasicInfoKeyExtension on BasicInfoKey {
  String get value {
    switch (this) {
      case BasicInfoKey.nickName:
        return 'NickName';
      case BasicInfoKey.age:
        return 'Age';
      case BasicInfoKey.language:
        return 'Language';
      case BasicInfoKey.living:
        return 'Living';
      case BasicInfoKey.education:
        return 'Education';
      case BasicInfoKey.occupation:
        return 'Occupation';
      case BasicInfoKey.height:
        return 'Height';
      case BasicInfoKey.bodyType:
        return 'Body type';
      case BasicInfoKey.marital:
        return 'Marital';
      case BasicInfoKey.relationshipGoal:
        return 'Relationship goal';
      case BasicInfoKey.test1:
        return 'test test test test test test very Long key';
      case BasicInfoKey.test2:
        return 'test2';
    }
  }
}

class TwoSelectData {
  final String value1;
  final String value2;

  TwoSelectData({required this.value1, required this.value2});

  @override
  String toString() {
    return '$value2, $value1';
  }
}

class MultiSelectData {
  final List<String> values;

  MultiSelectData({required this.values});

  @override
  String toString() {
    return values.join(', ');
  }
}

const educationList = [
  'High School',
  'Bachelor\'s Degree',
  'Master',
  'PHD',
];

const bodyTypeList = [
  'Slim',
  'Medium',
  'Obesity',
];

const maritalStatusList = [
  'Single',
  'Married',
  'Married and had children',
  // 'Divorced',
  // 'Widowed',
];

const relationshipGoalList = [
  'Serious',
  'Relaxed',
  'Want to have kids',
];

// todo this just test
const heightList = [
  '150cm',
  '155cm',
  '160cm',
  '165cm',
  '170cm',
  '175cm',
  '180cm',
  '185cm',
  '190cm',
  '195cm',
];

const testLanguageList = [
  'English',
  'Japanese',
  'Korean',
  'Chinese',
  'Spanish',
  'French',
  'German',
  'Italian',
  'Russian',
  'Portuguese',
  'Arabic',
  'Hindi',
  'Bengali',
  'Punjabi',
  'Telugu',
  'Marathi',
  'Tamil',
  'Urdu',
  'Gujarati',
  'Kannada',
  'Malayalam',
  'Sindhi',
  'Odia',
  'Nepali',
  'Assamese',
  'Maithili',
  'Santali',
];

enum BasicType {
  textField, // just edit in same page
  singleEdit, // go to another page with one edit
  twoSelect, // go to another page with two select
  singleSelect, // just select by a dialog in same page
  multiSelect, // go to another page with multi select
}

class BasicInfoItem extends StatelessWidget {
  final List<BasicInfoBean> pairList;
  final bool isEdit;
  final ValueChanged<List<BasicInfoBean>>? onChanged;

  const BasicInfoItem({super.key, required this.pairList, this.isEdit = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    debugPrint('BasicInfoItem build');
    return DetailItem(
        title: 'Basic Information',
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pairList.asMap().entries.map((entry) {
              return _buildListItem(entry.key);
            }).toList()));
  }

  List<String> _getSingleItems(BasicInfoKey key) {
    switch (key) {
      case BasicInfoKey.education:
        return educationList;
      case BasicInfoKey.bodyType:
        return bodyTypeList;
      case BasicInfoKey.marital:
        return maritalStatusList;
      case BasicInfoKey.relationshipGoal:
        return relationshipGoalList;
      case BasicInfoKey.height:
        return heightList;
      default:
        return [];
    }
  }

  List<String> _getMultiItems(BasicInfoKey key) {
    switch (key) {
      case BasicInfoKey.language:
        return testLanguageList;
      default:
        return [];
    }
  }

  Widget _buildListItem(int index) {
    BasicInfoBean bean = pairList[index];
    switch (bean.type) {
      case BasicType.singleEdit:
        return _SingleInfoItem(
          name: bean.key.value,
          value: bean.value.toString(),
          isEdit: isEdit,
          onChanged: (value) {
            pairList[index] = BasicInfoBean(key: bean.key, value: value, type: bean.type);
          },
        );
      case BasicType.twoSelect:
        return _TwoSelectItem(
            name: bean.key.value,
            value: bean.value as TwoSelectData,
            isEdit: isEdit,
            onChanged: (value) {
              pairList[index] = BasicInfoBean(key: bean.key, value: value, type: bean.type);
            });
      case BasicType.singleSelect:
        return _SingleSelectItem(
          name: bean.key.value,
          value: bean.value.toString(),
          isEdit: isEdit,
          onChanged: (value) {
            pairList[index] = BasicInfoBean(key: bean.key, value: value, type: bean.type);
          },
          items: _getSingleItems(bean.key),
        );
      case BasicType.textField:
        return _SingleTextFieldItem(
            name: bean.key.value,
            value: bean.value.toString(),
            isEdit: isEdit,
            onChanged: (value) {
              debugPrint('${bean.key.value} onChanged $value');
              pairList[index] = BasicInfoBean(key: bean.key, value: value, type: bean.type);
            });
      case BasicType.multiSelect:
        return _MultiSelectItem(
          name: bean.key.value,
          value: bean.value as MultiSelectData,
          isEdit: isEdit,
          items: _getMultiItems(bean.key),
        );
    }
  }
}

/// item key text
class _KeyText extends StatelessWidget {
  final String value;

  const _KeyText({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 13,
        height: 15.5 / 13,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}

/// item value text
class _ValueText extends StatelessWidget {
  final String value;

  const _ValueText({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 13,
        height: 15.5 / 13,
        fontWeight: FontWeight.w400,
        color: DreamerColors.grey800,
      ),
    );
  }
}

class _RightArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8),
      child: SizedBox(
        child: Icon(
          DreamerIcons.arrowRight,
          color: DreamerColors.grey600,
          size: 24,
        ),
      ),
    );
  }
}

class _DownArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8),
      child: Icon(
        DreamerIcons.arrowDown,
        color: DreamerColors.grey600,
        size: 24,
      ),
    );
  }
}

class _ItemWithDivider extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _ItemWithDivider({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (onTap == null) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        child,
        Container(
          width: double.infinity,
          height: 1,
          color: DreamerColors.divider,
        ),
      ]);
    } else {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
          onTap: () {
            onTap!();
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 38),
            child: child,
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: DreamerColors.divider,
        ),
      ]);
    }
  }
}

class _ItemNoDivider extends StatelessWidget {
  final Widget child;

  const _ItemNoDivider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 25),
      child: child,
    );
  }
}

/// below is basic information item

class _SingleInfoItem extends StatefulWidget {
  final String name;
  final String value;
  final bool isEdit;
  final ValueChanged<String>? onChanged;

  const _SingleInfoItem({required this.name, required this.value, required this.isEdit, this.onChanged});

  @override
  State<StatefulWidget> createState() => _SingleInfoItemState();
}

class _SingleInfoItemState extends State<_SingleInfoItem> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    Widget? arrow;
    if (widget.isEdit) {
      arrow = _RightArrow();
    } else {
      arrow = null;
    }
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _KeyText(value: widget.name),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 5,
          child: _ValueText(value: _value),
        ),
        if (arrow != null) arrow
      ],
    );
    if (widget.isEdit) {
      return _ItemWithDivider(
        child: content,
        onTap: () async {
          final res = await Navigator.of(context).push(Right2LeftRouter(
            child: EditSingleItemPage(
              title: widget.name,
              oldValue: _value,
            ),
          ));
          if (res != null && res is String) {
            setState(() {
              _value = res;
              widget.onChanged?.call(res);
            });
          }
        },
      );
    } else {
      return _ItemNoDivider(child: content);
    }
  }
}

class _TwoSelectItem extends StatefulWidget {
  final String name;
  final TwoSelectData value;
  final bool isEdit;
  final ValueChanged<TwoSelectData>? onChanged;

  const _TwoSelectItem({required this.name, required this.value, required this.isEdit, this.onChanged});

  @override
  State<StatefulWidget> createState() => _TwoSelectItemState();
}

class _TwoSelectItemState extends State<_TwoSelectItem> {
  late TwoSelectData _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    Widget? arrow;
    if (widget.isEdit) {
      arrow = _RightArrow();
    } else {
      arrow = null;
    }
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _KeyText(value: widget.name),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 5,
          child: _ValueText(value: _value.toString()),
        ),
        if (arrow != null) arrow
      ],
    );
    if (widget.isEdit) {
      return _ItemWithDivider(
        child: content,
        onTap: () async {
          final res = await Navigator.of(context).push(Right2LeftRouter(
            child: EditTwoSelectItemPage(
              title: widget.name,
              value: _value,
            ),
          ));
          if (res != null && res is TwoSelectData) {
            setState(() {
              _value = res;
              widget.onChanged?.call(res);
            });
          }
        },
      );
    } else {
      return _ItemNoDivider(child: content);
    }
  }
}

class _SingleSelectItem extends StatefulWidget {
  final String name;
  final String value;
  final bool isEdit;
  final ValueChanged<String>? onChanged;
  final List<String> items;

  const _SingleSelectItem(
      {required this.name, required this.value, required this.isEdit, this.onChanged, required this.items});

  @override
  State<StatefulWidget> createState() => _SingleSelectItemState();
}

class _SingleSelectItemState extends State<_SingleSelectItem> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    Widget? arrow;
    if (widget.isEdit) {
      arrow = _DownArrow();
    } else {
      arrow = null;
    }
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _KeyText(value: widget.name),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 5,
          child: _ValueText(value: _value),
        ),
        if (arrow != null) arrow
      ],
    );
    if (widget.isEdit) {
      return _ItemWithDivider(
        child: content,
        onTap: () async {
          _showBottomSheet(context, widget.name, widget.items, _value);
        },
      );
    } else {
      return _ItemNoDivider(child: content);
    }
  }

  _showBottomSheet(BuildContext context, String title, List<String> items, String value) async {
    final res = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) {
        return EditSingleDialogContent(
          title: title,
          items: items,
          value: value,
        );
      },
    );
    if (res != null && res is String) {
      setState(() {
        _value = res;
        widget.onChanged?.call(res);
      });
    }
  }
}

class _SingleTextFieldItem extends StatelessWidget {
  final String name;
  final String value;
  final bool isEdit;
  final ValueChanged<String>? onChanged;

  const _SingleTextFieldItem({required this.name, required this.value, required this.isEdit, this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget? arrow;
    if (isEdit) {
      // just for edit align
      arrow = const SizedBox(
        width: 32,
      );
    }
    Widget valueView;
    if (isEdit) {
      valueView = TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: TextEditingController(text: value),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        style: const TextStyle(
          fontSize: 13,
          height: 15.5 / 13,
          fontWeight: FontWeight.w400,
          color: DreamerColors.grey800,
        ),
        onChanged: (value) {
          onChanged?.call(value);
        },
      );
    } else {
      valueView = _ValueText(value: value);
    }
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _KeyText(value: name),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 5,
          child: valueView,
        ),
        if (arrow != null) arrow
      ],
    );
    if (isEdit) {
      return _ItemWithDivider(
        child: content,
      );
    } else {
      return _ItemNoDivider(child: content);
    }
  }
}

class _MultiSelectItem extends StatefulWidget {
  final String name;
  final MultiSelectData value;
  final bool isEdit;
  final ValueChanged<MultiSelectData>? onChanged;
  final List<String> items;

  const _MultiSelectItem({
    required this.name,
    required this.value,
    required this.isEdit,
    required this.items,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _MultiSelectItemState();
}

class _MultiSelectItemState extends State<_MultiSelectItem> {
  late MultiSelectData _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    Widget? arrow;
    if (widget.isEdit) {
      arrow = _RightArrow();
    } else {
      arrow = null;
    }
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _KeyText(value: widget.name),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 5,
          child: _ValueText(value: _value.toString()),
        ),
        if (arrow != null) arrow
      ],
    );
    if (widget.isEdit) {
      return _ItemWithDivider(
        child: content,
        onTap: () async {
          final res = await Navigator.of(context).push(Right2LeftRouter(
            child: EditMultiSelectItemPage(
              title: widget.name,
              value: _value,
              items: widget.items,
            ),
          ));
          if (res != null && res is MultiSelectData) {
            setState(() {
              _value = res;
              widget.onChanged?.call(res);
            });
          }
        },
      );
    } else {
      return _ItemNoDivider(child: content);
    }
  }
}
