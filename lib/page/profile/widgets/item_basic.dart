import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/edit_pages/edit_multi_select_page.dart';
import 'package:dreamer/page/profile/edit_pages/edit_single_page.dart';
import 'package:dreamer/page/profile/edit_pages/edit_single_select_dialog.dart';
import 'package:dreamer/page/profile/edit_pages/edit_two_select_page.dart';
import 'package:dreamer/page/profile/widgets/base_detail_item.dart';
import 'package:dreamer/request/bean/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Basic information item
/// [key] is the title of the information
/// [value] is the content of the information
/// [type] is the type of the information, default is [BasicType.right]
class BasicInfoBean {
  final BasicInfoKey key;
  final Object? value;
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
    }
  }
}

class TwoSelectData {
  final String value1;
  final String? value2;

  TwoSelectData({required this.value1, required this.value2});

  @override
  String toString() {
    if (value2 == null) {
      return value1;
    }
    return '$value2, $value1';
  }
}

class MultiSelectData {
  final List<String> values;

  MultiSelectData({required this.values});

  factory MultiSelectData.from(String? jsonStr) {
    if (jsonStr == null) {
      return MultiSelectData(values: []);
    }
    return MultiSelectData(values: jsonStr.split(', '));
  }

  @override
  String toString() {
    return values?.join(', ') ?? '';
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
// min:130cm max:220cm
final heightList = List.generate(91, (index) => '${index + 130}cm').toList()..add('220cm+');
// final heightList = List.generate(220, (index) => '${index + 1}cm').toList()..add('220cm+');

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
  text, // just text
  textField, // just edit in same page
  singleEdit, // go to another page with one edit
  twoSelect, // go to another page with two select
  singleSelect, // just select by a dialog in same page
  multiSelect, // go to another page with multi select
}

class BasicInfoItem extends StatelessWidget {
  final ProfileInfo profileInfo;
  final bool isEdit;
  final ValueChanged<BasicInfoBean>? onChanged;

  const BasicInfoItem({super.key, required this.profileInfo, this.isEdit = false, this.onChanged});

  _getAge(int birthday) {
    final now = DateTime.now();
    final birth = DateTime.fromMillisecondsSinceEpoch(birthday);
    final age = now.year - birth.year;
    if (now.month < birth.month || (now.month == birth.month && now.day < birth.day)) {
      return age - 1;
    }
    return age;
  }

  List<BasicInfoBean> get pairList => [
        BasicInfoBean(key: BasicInfoKey.nickName, value: profileInfo.nickname, type: BasicType.singleEdit),
        BasicInfoBean(key: BasicInfoKey.age, value: _getAge(profileInfo.birthday!), type: BasicType.text),
        BasicInfoBean(
          key: BasicInfoKey.language,
          value: MultiSelectData(values: profileInfo.languages ?? []),
          type: BasicType.multiSelect,
        ),
        BasicInfoBean(
            key: BasicInfoKey.living,
            value: TwoSelectData(value1: profileInfo.livingCountry!, value2: profileInfo.livingState),
            type: BasicType.twoSelect),
        BasicInfoBean(key: BasicInfoKey.education, value: profileInfo.education, type: BasicType.singleSelect),
        BasicInfoBean(key: BasicInfoKey.occupation, value: profileInfo.occupation, type: BasicType.singleEdit),
        // default height is 170cm
        BasicInfoBean(
            key: BasicInfoKey.height, value: profileInfo.height ?? heightList[0], type: BasicType.singleSelect),
        BasicInfoBean(key: BasicInfoKey.bodyType, value: profileInfo.bodyType, type: BasicType.singleSelect),
        BasicInfoBean(key: BasicInfoKey.marital, value: profileInfo.maritalStatus, type: BasicType.singleSelect),
        BasicInfoBean(
            key: BasicInfoKey.relationshipGoal, value: profileInfo.relationshipGoal, type: BasicType.singleSelect),
      ];

  @override
  Widget build(BuildContext context) {
    debugPrint('BasicInfoItem build: ${profileInfo.nickname}');
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

  _onItemChanged(BasicInfoBean oldBean, Object value, int index) {
    BasicInfoBean newBean = BasicInfoBean(key: oldBean.key, value: value, type: oldBean.type);
    pairList[index] = newBean;
    onChanged?.call(newBean);
  }

  Widget _buildListItem(int index) {
    BasicInfoBean bean = pairList[index];
    switch (bean.type) {
      case BasicType.text:
        return _TextInfoItem(name: bean.key.value, value: bean.value.toString(), isEdit: isEdit);
      case BasicType.singleEdit:
        return _SingleInfoItem(
          name: bean.key.value,
          value: bean.value?.toString(),
          isEdit: isEdit,
          onChanged: (value) => _onItemChanged(bean, value, index),
        );
      case BasicType.twoSelect:
        return _TwoSelectItem(
            name: bean.key.value,
            value: bean.value as TwoSelectData,
            isEdit: isEdit,
            onChanged: (value) => _onItemChanged(bean, value, index));
      case BasicType.singleSelect:
        return _SingleSelectItem(
          name: bean.key.value,
          value: bean.value?.toString(),
          isEdit: isEdit,
          onChanged: (value) => _onItemChanged(bean, value, index),
          items: _getSingleItems(bean.key),
        );
      case BasicType.textField:
        return _SingleTextFieldItem(
            name: bean.key.value,
            value: bean.value?.toString(),
            isEdit: isEdit,
            onChanged: (value) => _onItemChanged(bean, value, index));
      case BasicType.multiSelect:
        return _MultiSelectItem(
          name: bean.key.value,
          value: bean.value as MultiSelectData,
          isEdit: isEdit,
          items: _getMultiItems(bean.key),
          onChanged: (value) => _onItemChanged(bean, value, index),
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
  final String? value;

  const _ValueText({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value ?? '',
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
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
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

class _TextInfoItem extends StatelessWidget {
  final bool isEdit;
  final String name;
  final String value;

  const _TextInfoItem({required this.name, required this.value, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      height: 38,
      child: Row(
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
            child: _ValueText(value: value),
          ),
        ],
      ),
    );
    if (isEdit) {
      return _ItemWithDivider(child: content);
    } else {
      return _ItemNoDivider(child: content);
    }
  }
}

class _SingleInfoItem extends StatefulWidget {
  final String name;
  final String? value;
  final bool isEdit;
  final ValueChanged<String>? onChanged;

  const _SingleInfoItem({required this.name, required this.value, required this.isEdit, this.onChanged});

  @override
  State<StatefulWidget> createState() => _SingleInfoItemState();
}

class _SingleInfoItemState extends State<_SingleInfoItem> {
  late String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant _SingleInfoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
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
  void didUpdateWidget(covariant _TwoSelectItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
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
  final String? value;
  final bool isEdit;
  final ValueChanged<String>? onChanged;
  final List<String> items;

  const _SingleSelectItem(
      {required this.name, required this.value, required this.isEdit, this.onChanged, required this.items});

  @override
  State<StatefulWidget> createState() => _SingleSelectItemState();
}

class _SingleSelectItemState extends State<_SingleSelectItem> {
  late String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant _SingleSelectItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
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

  _showBottomSheet(BuildContext context, String title, List<String> items, String? value) async {
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
  final String? value;
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
  void didUpdateWidget(covariant _MultiSelectItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
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
