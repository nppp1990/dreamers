import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';

class QuizStepIndicator extends StatelessWidget {
  final int total;
  final int current;
  final double gap;
  final double height;

  const QuizStepIndicator({
    super.key,
    required this.total,
    required this.current,
    this.gap = 5,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        return Expanded(
          child: Container(
            height: height,
            margin: EdgeInsets.only(right: index == total - 1 ? 0 : gap),
            decoration: BoxDecoration(
              color: index == current ? DreamerColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      }),
    );
  }
}

class QuizOptionListView extends StatefulWidget {
  final List<String> options;
  final int? selectedOption;
  final ValueChanged<int>? onSelected;

  const QuizOptionListView({super.key, required this.options, this.selectedOption, this.onSelected});


  @override
  State<StatefulWidget> createState() => _QuizOptionViewState();
}

class _QuizOptionViewState extends State<QuizOptionListView> {
  int? _index;

  @override
  void initState() {
    super.initState();
    _index = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.options.length; i++)
          _buildOption(i, widget.options[i]),
      ],
    );
  }

  Widget _buildOption(int index, String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _index = index;
        });
        widget.onSelected?.call(index);
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 64),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: _index == index ? DreamerColors.secondary : const Color(0x99FFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            option,
            style: const TextStyle(
              fontSize: 13,
              height:15.5 / 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
