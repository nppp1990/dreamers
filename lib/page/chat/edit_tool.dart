import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/chat/chat_config.dart';
import 'package:dreamer/page/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

typedef EditSendCallback = void Function(String value, bool isImage);

class EditToolView extends StatefulWidget {
  final ChatController controller;
  final EditSendCallback onSend;

  const EditToolView({super.key, required this.onSend, required this.controller});

  @override
  State<StatefulWidget> createState() => _EditToolViewState();
}

class _EditToolViewState extends State<EditToolView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _value = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  EditToolConfig get editConfig => widget.controller.chatConfig.editToolConfig;

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final bottomPadding = viewInsets.bottom == 0 ? viewPadding.bottom : 0.0;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
          color: Colors.white,
          width: double.infinity,
          height: editConfig.height,
          child: Row(children: [
            SizedBox(
              width: editConfig.editHorizontalPadding,
            ),
            GestureDetector(
              onTap: _pickImage,
              child: SvgPicture.asset(
                'assets/images/icons/ic_picture.svg',
                width: editConfig.iconSize,
                height: editConfig.iconSize,
                colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 13,
                height: 15 / 13,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Colors.white,
                hintStyle: const TextStyle(color: DreamerColors.grey2),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: DreamerColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: DreamerColors.grey),
                ),
              ),
            )),
            GestureDetector(
              onTap: _value.isEmpty ? null : () => _enterSend(),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.asset(
                  'assets/images/icons/ic_send.svg',
                  width: editConfig.iconSize,
                  height: editConfig.iconSize,
                  colorFilter:
                      ColorFilter.mode(_value.isEmpty ? DreamerColors.grey : DreamerColors.primary, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(
              width: editConfig.editHorizontalPadding,
            ),
          ])),
    );
  }

  _enterSend() {
    if (_value.isNotEmpty) {
      widget.onSend(_value, false);
      setState(() {
        _value = '';
      });
      _controller.clear();
    }
  }

  _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      widget.onSend(pickedFile.path, true);
    }
  }
}
