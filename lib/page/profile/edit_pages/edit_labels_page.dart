import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/profile/widgets/edit_header.dart';
import 'package:flutter/material.dart';

class EditLabelsPage extends StatefulWidget {
  final String title;

  const EditLabelsPage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _EditLabelsPageState();
}

class _EditLabelsPageState extends State<EditLabelsPage> {
  static Map<String, List<LabelWithStatus>> testLabelMap = {
    'Sports': [
      LabelWithStatus(name: '🌿 Soccer Player', isSelected: true),
      LabelWithStatus(name: '🌿 Basketball Enthusiast'),
      LabelWithStatus(name: '🌿 Tennis Player', isSelected: true),
      LabelWithStatus(name: '🌿 Swimming Lover'),
      LabelWithStatus(name: '🌿 Yoga Practitioner'),
    ],
    'Music': [
      LabelWithStatus(name: '🌿 Nature'),
      LabelWithStatus(name: '🏝️ Travel', isSelected: true),
      LabelWithStatus(name: '✍️ Writing'),
      LabelWithStatus(name: '🌿 Guitarist'),
      LabelWithStatus(name: 'Pianist'),
      LabelWithStatus(name: 'Drummer'),
      LabelWithStatus(name: 'Violinist'),
      LabelWithStatus(name: 'Singer'),
      LabelWithStatus(name: 'Hip Hop Dancer'),
      LabelWithStatus(name: 'Hip-Hop Enthusiast'),
      LabelWithStatus(name: 'Jazz Lover'),
    ],
    'Food': [
      LabelWithStatus(name: '🌿 Nature'),
      LabelWithStatus(name: '🏝️ Travel'),
      LabelWithStatus(name: '✍️ Writing'),
      LabelWithStatus(name: '🌿 Nature'),
      LabelWithStatus(name: '🏝️ Travel'),
      LabelWithStatus(name: '✍️ Writing'),
      LabelWithStatus(name: '🌿 Nature'),
      LabelWithStatus(name: '🏝️ Travel'),
      LabelWithStatus(name: '✍️ Writing'),
      LabelWithStatus(name: '🌿 Nature'),
      LabelWithStatus(name: '🏝️ Travel'),
      LabelWithStatus(name: '✍️ Writing'),
    ],
    // 1. Bookworm 📚
    // 2. Movie Buff 🎬
    // 3. Foodie 🍣
    // 4. Traveler 🌍
    // 5. Gamer 🎮
    // 6. Gardener 🌻
    // 7. Photographer 📸
    // 8. Blogger ✍️
    // 9. Vlogger 📹
    // 10. DIY Enthusiast 🔨
    // 11. Tech Savvy 💻
    // 12. Fashion Enthusiast 👗
    // 13. Knitter 🧶
    // 14. Puzzle Solver 🧩
    // 15. Animal Lover 🐶
    // 16. Environmentalist 🌳
    // 17. Volunteer 🙋‍♂️
    // 18. Meditation Practitioner 🧘‍♂️
    // 19. Cook 🍳
    // 20. Baker 🥖
    // 21. Collector 🗃️
    // 22. Hiker 🥾
    // 23. Fisher 🎣
    // 24. Birdwatcher 🦉
    // 25. Language Learner 🗣️
    'Other habits': [
      LabelWithStatus(name: '📚 Bookworm'),
      LabelWithStatus(name: '🎬 Movie Buff'),
      LabelWithStatus(name: '🍣 Foodie'),
      LabelWithStatus(name: '🌍 Traveler'),
      LabelWithStatus(name: '🎮 Gamer'),
      LabelWithStatus(name: '🌻 Gardener'),
      LabelWithStatus(name: '📸 Photographer'),
      LabelWithStatus(name: '✍️ Blogger'),
      LabelWithStatus(name: '📹 Vlogger'),
      LabelWithStatus(name: '🔨 DIY Enthusiast'),
      LabelWithStatus(name: '💻 Tech Savvy'),
      LabelWithStatus(name: '👗 Fashion Enthusiast'),
      LabelWithStatus(name: '🧶 Knitter'),
      LabelWithStatus(name: '🧩 Puzzle Solver'),
      LabelWithStatus(name: '🐶 Animal Lover'),
      LabelWithStatus(name: '🌳 Environmentalist'),
      LabelWithStatus(name: '🙋‍♂️ Volunteer'),
      LabelWithStatus(name: '🧘‍♂️ Meditation Practitioner'),
      LabelWithStatus(name: '🍳 Cook'),
      LabelWithStatus(name: '🥖 Baker'),
      LabelWithStatus(name: '🗃️ Collector'),
      LabelWithStatus(name: '🥾 Hiker'),
      LabelWithStatus(name: '🎣 Fisher'),
      LabelWithStatus(name: '🦉 Birdwatcher'),
      LabelWithStatus(name: '🗣️ Language Learner'),
    ],
  };

  late Map<String, List<LabelWithStatus>> _labelMap;

  @override
  void initState() {
    super.initState();
    // deep copy from testLabelMap
    _labelMap =
        testLabelMap.map((key, value) => MapEntry(key, value.map<LabelWithStatus>((e) => e.copyWith()).toList()));
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return PageBackground(
      assetImage: const AssetImage('assets/images/bg_base1.png'),
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          EditHeader(
            title: widget.title,
            btnStr: 'Save',
            onDone: () {
              // todo
              //  print _labelMap
              // 遍历_labelMap，打印LabelWithStatus
              for (var entry in _labelMap.entries) {
                for (var labelWithStatus in entry.value) {
                  debugPrint(labelWithStatus.toString());
                }
              }
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 16, bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        _labelMap.entries.map<Widget>((entry) => _buildLabelsItem(entry.key, entry.value)).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelsItem(String labelTitle, List<LabelWithStatus> labels) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelTitle,
            style: const TextStyle(
              color: DreamerColors.primary,
              fontSize: 14,
              height: 16.7 / 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: labels
                  .map((labelWithStatus) => _LabelItem(
                        label: labelWithStatus.name,
                        isSelected: labelWithStatus.isSelected,
                        onSelected: (value) {
                          labelWithStatus.isSelected = value;
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelItem extends StatefulWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const _LabelItem({required this.label, required this.isSelected, required this.onSelected});

  @override
  State<StatefulWidget> createState() => _LabelItemState();
}

class _LabelItemState extends State<_LabelItem> {
  late bool _isSelected;

  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelected(_isSelected);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: _isSelected ? DreamerColors.secondary : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: DreamerColors.greyBorder,
            width: 1,
          ),
        ),
        child: Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12,
            height: 14.3 / 12,
            fontWeight: FontWeight.w500,
            color: DreamerColors.grey600,
          ),
        ),
      ),
    );
  }
}

class LabelWithStatus {
  final String name;
  bool isSelected;

  LabelWithStatus({required this.name, this.isSelected = false});

  copyWith({String? name, bool? isSelected}) {
    return LabelWithStatus(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  String toString() {
    return 'LabelWithStatus{name: $name, isSelected: $isSelected}';
  }
}
