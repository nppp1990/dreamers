import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef ValueCheck = String Function(String value);

class LabelTextFieldController extends ValueNotifier<String> {
  String textValue = '';

  LabelTextFieldController(super.value);

  set error(String error) {
    value = error;
    notifyListeners();
  }

  String get error => value;
}

class LabelTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final ValueCheck valueCheck;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final LabelTextFieldController controller;

  const LabelTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    required this.valueCheck,
    this.textInputAction,
    this.onChanged,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword ? true : false;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    debugPrint('Focus: ${_focusNode.hasFocus}----${widget.controller.textValue}---${widget.isPassword}');
    if (_focusNode.hasFocus) {
      // Future.delayed(const Duration(milliseconds: 1000), () {
      //   FocusScope.of(context).requestFocus();
      // });

    } else {
      widget.controller.error = widget.valueCheck(widget.controller.textValue);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: DreamerColors.danger),
    );
    Widget? passwordSuffixIcon = widget.isPassword
        ? InkWell(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 9),
              child: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: DreamerColors.grey600,
                size: 24,
              ),
            ),
          )
        : null;

    return ValueListenableBuilder<String>(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label,
                style: TextStyle(
                  fontSize: 12,
                  height: 14.4 / 12,
                  fontWeight: FontWeight.w400,
                  color: value.isNotEmpty ? DreamerColors.danger : DreamerColors.grey800,
                )),
            const SizedBox(height: 4),
            Listener(
              onPointerDown: (_) {
                FocusScope.of(context).requestFocus(_focusNode);
              },
              child: TextField(
                textInputAction: widget.textInputAction,
                autofocus: true,
                keyboardType: widget.isPassword ? TextInputType.visiblePassword : TextInputType.text,
                focusNode: _focusNode,
                onChanged: (value) {
                  widget.controller.textValue = value;
                  widget.onChanged?.call(value);
                },
                obscureText: _obscureText,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1,
                  color: DreamerColors.grey800,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: DreamerColors.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: DreamerColors.secondary),
                  ),
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                  error: value.isNotEmpty
                      ? Transform.translate(
                          offset: const Offset(-16, 0),
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 12,
                                height: 14.4 / 12,
                                fontWeight: FontWeight.w400,
                                color: DreamerColors.danger),
                          ))
                      : null,
                  suffixIconConstraints: widget.isPassword
                      ? const BoxConstraints(
                          minHeight: 40,
                          minWidth: 40,
                        )
                      : null,
                  suffixIcon: passwordSuffixIcon,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginButton({super.key, required this.text, required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFFA755FF)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class AuthLogin extends StatelessWidget {
  final String text;
  final String svgName;
  final VoidCallback onPressed;

  const AuthLogin({super.key, required this.text, required this.svgName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
            // minimumSize: WidgetStateProperty.all(const Size(double.infinity, 40)),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                svgName,
                width: 24,
                height: 24,
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 13,
                        color: DreamerColors.grey600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
