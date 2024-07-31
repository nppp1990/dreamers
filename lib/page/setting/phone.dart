import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/setting/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneSettingItem extends StatelessWidget {
  final String? phone;

  const PhoneSettingItem({super.key, this.phone});

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      name: 'Phone number',
      svgIcon: 'assets/images/icons/ic_phone.svg',
      hasArrow: true,
      onTap: () async {
        final res = await Navigator.of(context).push(Right2LeftRouter(child: PhonePage(oldPhone: phone)));
        if (res != null && res is String) {
          // todo
        }
      },
    );
  }
}


class PhonePage extends StatelessWidget {
  final String? oldPhone;

  const PhonePage({super.key, this.oldPhone});

  @override
  Widget build(BuildContext context) {
    final title = oldPhone == null ? 'Phone number' : 'Change Phone number';
    return NormalPage(
      title: title,
      child: _PhonePageContent(oldPhone: oldPhone),
    );
  }
}

class _PhonePageContent extends StatefulWidget {
  final String? oldPhone;

  const _PhonePageContent({this.oldPhone});

  @override
  State<_PhonePageContent> createState() => _PhonePageContentState();
}

class _PhonePageContentState extends State<_PhonePageContent> {
  late String _phone;
  late String _verifyCode;

  @override
  void initState() {
    super.initState();
    _phone = widget.oldPhone ?? '';
    _verifyCode = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        if (widget.oldPhone != null) ...[
          const SizedBox(height: 16),
          Text(
            'current Phone number: ${widget.oldPhone}',
            style: const TextStyle(
              fontSize: 12,
              height: 14.4 / 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          )
        ],
        const SizedBox(height: 16),
        EditCard(
          icon: SvgPicture.asset(
            'assets/images/icons/ic_phone.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              DreamerColors.grey600,
              BlendMode.srcIn,
            ),
          ),
          label: 'Phone',
          hintText: 'Please enter the Phone address to be bound',
          onChanged: (value) {
            _phone = value;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        EditCard(
          icon: SvgPicture.asset(
            'assets/images/icons/ic_verify_code.svg',
            width: 18,
            height: 21,
            colorFilter: const ColorFilter.mode(
              DreamerColors.grey600,
              BlendMode.srcIn,
            ),
          ),
          label: 'Verification code',
          hintText: 'Verification code',
          button: OutlinedButton(
            onPressed: _onClickSendVerifyCode,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: const BorderSide(color: DreamerColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              'Send',
              style: TextStyle(
                fontSize: 12,
                height: 14.3 / 12,
                fontWeight: FontWeight.w500,
                color: DreamerColors.primary,
              ),
            ),
          ),
          onChanged: (value) {
            _verifyCode = value;
          },
        ),
        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
          onPressed: _onClickConfirm,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            backgroundColor: DreamerColors.primary,
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(
              fontSize: 16,
              height: 19 / 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }

  void _onClickSendVerifyCode() {}

  void _onClickConfirm() {
    // todo
    debugPrint('phone: $_phone, verify code: $_verifyCode');
    Navigator.of(context).pop(_phone);
  }
}
