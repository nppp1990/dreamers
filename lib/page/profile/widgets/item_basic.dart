import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
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

  BasicInfoBean({required this.key, required this.value, this.type = BasicType.right});
}

enum BasicType {
  edit,
  right,
  down,
}

class BasicInfoItem extends StatelessWidget {
  final List<BasicInfoBean> pairList;
  final bool isEdit;
  final ValueChanged<List<BasicInfoBean>>? onChanged;

  const BasicInfoItem({super.key, required this.pairList, this.isEdit = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DetailItem(
        title: 'Basic Information',
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pairList.map((e) => _buildListItem(e)).toList()));
  }

  Widget _buildListItem(BasicInfoBean bean) {
    Widget? arrow;
    if (isEdit) {
      if (bean.type == BasicType.right) {
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
      } else if (bean.type == BasicType.down) {
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
    if (isEdit && bean.type == BasicType.edit) {
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
      if (bean.type != BasicType.edit) {
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
