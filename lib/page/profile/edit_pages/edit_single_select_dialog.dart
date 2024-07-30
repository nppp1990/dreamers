import 'package:dreamer/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditSingleDialogContent extends StatefulWidget {
  final String title;
  final List<String> items;
  final String value;

  const EditSingleDialogContent({required this.title, required this.items, required this.value});

  @override
  State<StatefulWidget> createState() => _EditSingleDialogContentState();
}

class _EditSingleDialogContentState extends State<EditSingleDialogContent> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.items.indexOf(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 40,
            width: double.infinity,
            color: DreamerColors.grey100,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 16,
                        height: 20 / 16,
                        fontWeight: FontWeight.w400,
                        color: DreamerColors.grey600,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 14,
                        height: 16 / 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 73,
                    height: 24,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: DreamerColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(widget.items[_index]);
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 12,
                          height: 14.3 / 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 215,
          width: double.infinity,
          color: Colors.white,
          // ios style picker todo need a Android style picker
          child: CupertinoPicker(
            itemExtent: 32,
            scrollController: FixedExtentScrollController(
              initialItem: _index,
            ),
            onSelectedItemChanged: (index) {
              _index = index;
            },
            children: [
              for (var i = 0; i < widget.items.length; i++)
                Center(
                  child: Text(
                    widget.items[i],
                    style: const TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 23,
                      height: 27 / 23,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF16191C),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}