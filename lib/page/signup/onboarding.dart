import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/data/dreamer_icons.dart';
import 'package:dreamer/page/signup/onboarding1.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> titleList = [
  'Enter your phone number',
  'Verify your phone number',
  'What is your nickname?',
  'Where is your region?',
  'Tell us your gender identity',
  'Tell us when is your birthdate',
  'Pick your profile picture'
];

const List<String?> subTitleList = [
  'The phone number will be verified',
  null,
  'Create a unique name that is only for you',
  'todo',
  'todo',
  'todo',
  'todo'
];

class SignupBasePage extends StatelessWidget {
  final int step;
  final String title;
  final String? subTitle;
  final Widget child;
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  const SignupBasePage(
      {super.key,
      required this.step,
      required this.title,
      this.subTitle,
      required this.child,
      this.onBack,
      this.onNext});

  @override
  Widget build(BuildContext context) {
    return PageBackground(
        assetImage: const AssetImage('assets/images/bg_base1.png'),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 56,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (step > 1)
                        _buildStepButton('Back', DreamerColors.black1, () {
                          Navigator.of(context).pop();
                          onBack?.call();
                        }),
                      const Spacer(),
                      _buildStepButton('Next', DreamerColors.primary, onNext),
                    ],
                  ),
                ),
                Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'Q$step',
                        style: const TextStyle(
                          height: 28 / 24,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    )),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    height: 24 / 20,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                if (subTitle != null)
                  Text(subTitle!,
                      style: const TextStyle(
                        height: 14 / 12,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: DreamerColors.grey800,
                      )),
                SizedBox(height: subTitle == null ? 22 : 8),
                StepIndicator(step: step),
                const SizedBox(height: 16),
                child,
              ],
            ),
          ),
        ));
  }

  _buildStepButton(String label, Color color, VoidCallback? onPressed) {
    return SizedBox(
      height: 24,
      width: 73,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class StepIndicator extends StatelessWidget {
  static const totalStep = 7;

  /// start from 1
  final int step;

  const StepIndicator({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
          children: List.generate(totalStep, (index) {
        // 横向间距6.5，高度4，宽度平均分布
        return Container(
          width: (MediaQuery.sizeOf(context).width - 32 - 6.5 * (totalStep - 1)) / totalStep,
          height: 4,
          margin: EdgeInsets.only(right: index == totalStep - 1 ? 0 : 6.5),
          decoration: BoxDecoration(
            color: index == step - 1 ? DreamerColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      })),
    );
  }
}

class NumberTextField extends StatelessWidget {
  final ValueChanged onChanged;

  const NumberTextField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 16,
        height: 1,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: DreamerColors.secondary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: DreamerColors.secondary, width: 1),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class DataSelector<T> extends StatelessWidget {
  final T? value;
  final String? hint;
  final ValueChanged<T?> onChanged;
  final List<T>? regionList;

  const DataSelector({super.key, required this.value, this.hint, required this.onChanged, this.regionList});

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      // width of DropdownButton depends on the maxWidth of the child
      value: value,
      hint: hint != null
          ? Text(
              hint!,
              style: const TextStyle(
                fontSize: 16,
                height: 1,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            )
          : null,
      iconStyleData: const IconStyleData(
        icon: Icon(DreamerIcons.arrowDown, color: DreamerColors.grey600),
        iconSize: 24,
      ),
      // remove underline
      underline: Container(),
      buttonStyleData: ButtonStyleData(
        padding: const EdgeInsets.only(left: 16, right: 8),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: DreamerColors.secondary, width: 1),
        ),
        // backgroundColor: Colors.white,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(8),
        // ),
      ),

      isExpanded: true,
      onChanged: onChanged,
      items: regionList
          ?.map((e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                e.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  height: 1,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              )))
          .toList(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Signup1();
  }
}
