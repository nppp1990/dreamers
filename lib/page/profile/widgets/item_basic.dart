import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/profile/edit_pages/edit_single_page.dart';
import 'package:dreamer/page/profile/edit_pages/edit_two_select_page.dart';
import 'package:dreamer/page/profile/widgets/base_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Basic information item
/// [key] is the title of the information
/// [value] is the content of the information
/// [type] is the type of the information, default is [BasicType.right]
class BasicInfoBean {
  final String key;
  final Object value;
  final BasicType type;

  BasicInfoBean({required this.key, required this.value, required this.type});
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

  Widget _buildListItem(int index) {
    debugPrint('BasicInfoItem _buildListItem $index');
    BasicInfoBean bean = pairList[index];
    switch (bean.type) {
      case BasicType.singleEdit:
        return _SingleInfoItem(
          name: bean.key,
          value: bean.value.toString(),
          isEdit: isEdit,
          onChanged: (value) {
            pairList[index] = BasicInfoBean(key: bean.key, value: value, type: bean.type);
          },
        );
      case BasicType.twoSelect:
        return _TwoSelectItem(
          name: bean.key,
          value: bean.value as TwoSelectData,
          isEdit: isEdit,
          onChanged: (value) {
            pairList[index] = BasicInfoBean(key: bean.key, value: value, type: bean.type);
          }
        );
      default:
        break;
    }

    Widget? arrow;
    if (isEdit) {
      if (bean.type == BasicType.singleEdit || bean.type == BasicType.twoSelect || bean.type == BasicType.multiSelect) {
        arrow = const Padding(
          padding: EdgeInsets.only(left: 8),
          child: SizedBox(
            child: Icon(
              DreamerIcons.arrowRight,
              color: Color(DreamerColors.grey600),
              size: 24,
            ),
          ),
        );
      } else if (bean.type == BasicType.singleSelect) {
        arrow = const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            DreamerIcons.arrowDown,
            color: Color(DreamerColors.grey600),
            size: 24,
          ),
        );
      } else {
        // just for edit align
        arrow = const SizedBox(
          width: 32,
        );
      }
    }
    Widget valueView;
    if (isEdit && bean.type == BasicType.textField) {
      valueView = TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: TextEditingController(text: bean.value.toString()),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 13,
          height: 15.5 / 13,
          fontWeight: FontWeight.w400,
          color: Color(DreamerColors.grey800),
        ),
        onChanged: (value) {
          // bean.value = value;
          // onChanged?.call(pairList);
        },
      );
    } else {
      valueView = Text(
        bean.value.toString(),
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 13,
          height: 15.5 / 13,
          fontWeight: FontWeight.w400,
          color: Color(DreamerColors.grey800),
        ),
      );
    }
    Widget content = Container(
      constraints: BoxConstraints(minHeight: isEdit ? 38 : 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              bean.key,
              style: const TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 13,
                height: 15.5 / 13,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
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
      ),
    );
    if (isEdit) {
      Widget itemWithDivider = Column(mainAxisSize: MainAxisSize.min, children: [
        content,
        Container(
          width: double.infinity,
          height: 1,
          color: const Color(DreamerColors.divider),
        ),
      ]);
      if (bean.type != BasicType.textField) {
        return GestureDetector(
          onTap: () {
            // onChanged?.call(pairList);
            print('onTap todo');
          },
          child: itemWithDivider,
        );
      } else {
        return itemWithDivider;
      }
    } else {
      return content;
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
        fontFamily: 'SF Pro Text',
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
        fontFamily: 'SF Pro Text',
        fontSize: 13,
        height: 15.5 / 13,
        fontWeight: FontWeight.w400,
        color: Color(DreamerColors.grey800),
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
          color: Color(DreamerColors.grey600),
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
        color: Color(DreamerColors.grey600),
        size: 24,
      ),
    );
  }
}

class _ItemWithDivider extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _ItemWithDivider({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          constraints: const BoxConstraints(minHeight: 38),
          child: child,
        ),
      ),
      Container(
        width: double.infinity,
        height: 1,
        color: const Color(DreamerColors.divider),
      ),
    ]);
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
