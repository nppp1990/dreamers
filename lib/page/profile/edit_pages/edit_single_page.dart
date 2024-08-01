import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/page/profile/widgets/edit_header.dart';
import 'package:flutter/material.dart';

class EditSingleItemPage extends StatefulWidget {
  final String title;
  final String oldValue;

  const EditSingleItemPage({super.key, required this.title, required this.oldValue});

  @override
  State<StatefulWidget> createState() => _EditSingleItemPageState();
}

class _EditSingleItemPageState extends State<EditSingleItemPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.oldValue);
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    // 36 is the height of the EditHeader, 20 is the paddingBottom of the text field
    final maxHeight = MediaQuery.sizeOf(context).height - statusBarHeight - 36 - 20;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          EditHeader(
            title: widget.title,
            btnStr: 'Save',
            onDone: () {
              Navigator.of(context).pop(_controller.text);
            },
          ),
          Expanded(
            child: Wrap(children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter ${widget.title}',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        isDense: true,
                      ),
                      style: const TextStyle(
                        fontSize: 13,
                        height: 15.5 / 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
