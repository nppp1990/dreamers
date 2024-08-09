import 'package:dreamer/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const SettingCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class SettingItem extends StatelessWidget {
  final String name;
  final String? value;
  final String? svgIcon;
  final VoidCallback? onTap;
  final bool hasArrow;

  const SettingItem({
    super.key,
    required this.name,
    this.value,
    this.svgIcon,
    this.onTap,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget item = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            if (svgIcon != null) ...[
              SvgPicture.asset(
                svgIcon!,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  DreamerColors.grey600,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  height: 18 / 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            if (value != null) ...[
              const SizedBox(width: 8),
              Text(
                value!,
                style: const TextStyle(
                  fontSize: 15,
                  height: 18 / 15,
                  fontWeight: FontWeight.w400,
                  color: DreamerColors.grey600,
                ),
              ),
            ],
            if (hasArrow) ...[
              SvgPicture.asset(
                'assets/images/icons/ic_arrow_right.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  DreamerColors.grey600,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ]),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: DreamerColors.divider2,
        ),
      ],
    );
    if (onTap != null) {
      return InkWell(
        onTap: () {
          onTap!();
        },
        child: item,
      );
    }
    return item;
  }
}

class EditCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final String hintText;
  final Widget? button;
  final ValueChanged<String> onChanged;
  final bool isPassword;

  const EditCard({
    super.key,
    required this.icon,
    required this.label,
    required this.hintText,
    this.button,
    this.isPassword = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Widget input = TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          height: 16.8 / 14,
          fontWeight: FontWeight.w400,
          color: DreamerColors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        isDense: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: DreamerColors.primary, width: 1),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: DreamerColors.grey, width: 1),
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
        height: 16.8 / 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      onChanged: onChanged,
    );
    return SettingCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                width: 8,
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  height: 16.8 / 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (button == null)
            input
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: input),
                const SizedBox(
                  width: 10,
                ),
                button!,
              ],
            ),
        ],
      ),
    );
  }
}

class SettingCheckItem extends StatefulWidget {
  final String name;
  final bool checked;
  final ValueChanged<bool>? onChanged;

  const SettingCheckItem({super.key, required this.name, required this.checked, this.onChanged});

  @override
  State<StatefulWidget> createState() => _SettingCheckItemState();
}

class _SettingCheckItemState extends State<SettingCheckItem> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 16.8 / 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: _value,
                  activeColor: DreamerColors.primary,
                  trackColor: const Color(0xFFD9D9D9),
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                    widget.onChanged?.call(value);
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: DreamerColors.divider,
        ),
      ],
    );
  }
}

/// no background
/// height is 40
/// one right arrow
class SettingItem2 extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const SettingItem2({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 16.8 / 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  'assets/images/icons/ic_arrow_right.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    DreamerColors.divider2,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: DreamerColors.divider,
          ),
        ],
      ),
    );
  }
}
