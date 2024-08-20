import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwipeCardInfo {
  final String userName;
  final String desc;
  final String avatarUrl;
  final String about;

  const SwipeCardInfo({required this.userName, required this.desc, required this.avatarUrl, required this.about});

  SwipeCardInfo copyWith({
    String? userName,
    String? desc,
    String? avatarUrl,
    String? about,
  }) {
    return SwipeCardInfo(
      userName: userName ?? this.userName,
      desc: desc ?? this.desc,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      about: about ?? this.about,
    );
  }
}

class SwipeCard extends StatelessWidget {
  final SwipeCardInfo info;

  // final double height;
  final Color color;
  final VoidCallback onSkip;
  final VoidCallback onLike;

  const SwipeCard({
    super.key,
    required this.info,
    this.color = Colors.white,
    required this.onSkip,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        info.userName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24,
                          height: 28.6 / 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.desc,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 14.3 / 12,
                          fontWeight: FontWeight.w500,
                          color: DreamerColors.brown,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(info.avatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
                backgroundColor: DreamerColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                _viewDetail(context);
              },
              child: const Text(
                'View Detail',
                style: TextStyle(
                  fontSize: 12,
                  height: 14.3 / 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(
            height: 1,
            thickness: 1,
            color: DreamerColors.divider,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 15,
                height: 18 / 15,
                fontWeight: FontWeight.w700,
                color: DreamerColors.primary,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                info.about,
                style: const TextStyle(
                  fontSize: 13,
                  height: 13 / 15.5,
                  fontWeight: FontWeight.w500,
                  color: DreamerColors.grey800,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 28),
            child: Row(
              children: [
                _buildStepButton(
                  text: 'Skip',
                  icon: 'assets/images/icons/ic_skip.svg',
                  backgroundColor: DreamerColors.grey300,
                  onPressed: onSkip,
                ),
                const Spacer(),
                _buildStepButton(
                  text: 'Like!',
                  icon: 'assets/images/icons/ic_like.svg',
                  backgroundColor: DreamerColors.primary,
                  onPressed: onLike,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _viewDetail(BuildContext context) {}

  Widget _buildStepButton({
    required String text,
    required String icon,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                width: 32,
                height: 32,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  height: 16.4 / 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
