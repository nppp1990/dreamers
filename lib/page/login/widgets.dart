import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const PasswordTextField({super.key, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 16,
        color: Color(DreamerColors.grey800),
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(DreamerColors.primary)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(DreamerColors.secondary)),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 40,
          minWidth: 40,
        ),
        suffixIcon:  InkWell(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 9),
            child: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: const Color(DreamerColors.grey600),
              size: 24,
            ),
          ),
        )
      ),
    );
  }
}

class NameTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const NameTextField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 16,
        color: Color(DreamerColors.grey800),
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: 'Name',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(DreamerColors.primary)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(DreamerColors.secondary)),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFFA755FF)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
          ),
          // minimumSize: WidgetStateProperty.all(const Size(double.infinity, 36)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'SF Pro Text',
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
                        fontFamily: 'SF Pro Text',
                        fontSize: 13,
                        color: Color(DreamerColors.grey600),
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
