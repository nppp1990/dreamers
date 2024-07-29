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
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          EditHeader(
            title: widget.title,
            btnStr: 'Done',
            onDone: () {
              Navigator.of(context).pop(_controller.text);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter ${widget.title}',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
