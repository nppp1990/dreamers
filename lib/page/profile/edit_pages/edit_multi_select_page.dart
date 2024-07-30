import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/profile/widgets/edit_header.dart';
import 'package:dreamer/page/profile/widgets/item_basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditMultiSelectItemPage extends StatefulWidget {
  final String title;
  final MultiSelectData value;
  final List<String> items;

  const EditMultiSelectItemPage({super.key, required this.title, required this.value, required this.items});

  @override
  State<StatefulWidget> createState() => _EditMultiSelectItemPageState();
}

class _EditMultiSelectItemPageState extends State<EditMultiSelectItemPage> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.value.values);
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery
        .viewPaddingOf(context)
        .top;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          EditHeader(
            title: widget.title,
            btnStr: 'Save',
            onDone: () {
              if (_selectedItems.isEmpty) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Please select at least one item')));
                return;
              }
              Navigator.of(context).pop(MultiSelectData(values: _selectedItems));
            },
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 26),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Multiple selections allowed',
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 12,
                        height: 14.4 / 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_selectedItems.contains(item)) {
                                _selectedItems.remove(item);
                              } else {
                                _selectedItems.add(item);
                              }
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontFamily: 'SF Pro Text',
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    if (_selectedItems.contains(item))
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 7),
                                        child: SvgPicture.asset(
                                          'assets/images/icons/ic_checked.svg',
                                          width: 18,
                                          height: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: DreamerColors.divider,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
