import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/setting/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailSettingItem extends StatefulWidget {
  final String? email;

  const EmailSettingItem({super.key, this.email});

  @override
  State<EmailSettingItem> createState() => _EmailSettingItemState();
}

class _EmailSettingItemState extends State<EmailSettingItem> {
  late String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      name: 'Email',
      svgIcon: 'assets/images/icons/ic_email.svg',
      value: _value,
      hasArrow: true,
      onTap: () async {
        final res = await Navigator.of(context).push(Right2LeftRouter(child: EmailPage(oldEmail: _value)));
        if (res != null && res is String) {
          setState(() {
            _value = res;
          });
        }
      },
    );
  }
}

class EmailPage extends StatelessWidget {
  final String? oldEmail;

  const EmailPage({super.key, this.oldEmail});

  @override
  Widget build(BuildContext context) {
    final title = oldEmail == null ? 'Email' : 'Change Email';
    return NormalPage(
      title: title,
      child: _EmailPageContent(oldEmail: oldEmail),
    );
  }
}

class _EmailPageContent extends StatefulWidget {
  final String? oldEmail;

  const _EmailPageContent({this.oldEmail});

  @override
  State<_EmailPageContent> createState() => _EmailPageContentState();
}

class _EmailPageContentState extends State<_EmailPageContent> {
  late String _email;
  late String _verifyCode;

  @override
  void initState() {
    super.initState();
    _email = widget.oldEmail ?? '';
    _verifyCode = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        if (widget.oldEmail != null) ...[
          const SizedBox(height: 16),
          Text(
            'current email: ${widget.oldEmail}',
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
            'assets/images/icons/ic_email2.svg',
            width: 20,
            height: 16,
            colorFilter: const ColorFilter.mode(
              DreamerColors.grey600,
              BlendMode.srcIn,
            ),
          ),
          label: 'Email',
          hintText: 'Please enter the email address to be bound',
          onChanged: (value) {
            _email = value;
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
    debugPrint('email: $_email, verify code: $_verifyCode');
    Navigator.of(context).pop(_email);
  }
}
