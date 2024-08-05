import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/home/swipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LikeEachPage extends StatelessWidget {
  final SwipeCardInfo otherInfo;
  static const testUrl = 'https://ww1.sinaimg.cn/mw690/00810laVly1hruogbosb0j30kg0kftd9.jpg';

  const LikeEachPage({super.key, required this.otherInfo});

  @override
  Widget build(BuildContext context) {
    return NormalPage(
        title: '',
        child: Column(
          children: [
            const SizedBox(height: 44),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'You and ',
                  style: const TextStyle(
                    color: DreamerColors.grey800,
                    fontSize: 24,
                    height: 28.8 / 24,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(text: otherInfo.userName, style: const TextStyle(color: DreamerColors.primary)),
                    const TextSpan(text: ' liked each other!'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 66),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 120 + 10,
                width: 120 + 96,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: ClipPath(
                        clipper: VerticalClipper(isFromLeft: true, clipWidth: 108),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(otherInfo.avatarUrl),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: ClipPath(
                        clipper: VerticalClipper(isFromLeft: false, clipWidth: 108),
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(testUrl),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset('assets/images/icons/ic_like_border.png', width: 72, height: 72),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 72),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildBottomBtn(
                      icon: 'assets/images/icons/ic_fantasy.svg',
                      label: 'Steal his dream',
                      isPrimary: true,
                      onTap: () {
                        // todo like
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildBottomBtn(
                      icon: 'assets/images/icons/ic_swipe.svg',
                      label: 'Keep swiping',
                      isPrimary: false,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _buildBottomBtn({
    required String icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: isPrimary ? DreamerColors.primary : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: isPrimary ? BorderSide.none : const BorderSide(color: DreamerColors.divider, width: 1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(isPrimary ? Colors.white : DreamerColors.primary, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              height: 19 / 16,
              color: isPrimary ? Colors.white : DreamerColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalClipper extends CustomClipper<Path> {
  final bool isFromLeft;
  final double clipWidth;

  VerticalClipper({super.reclip, required this.isFromLeft, required this.clipWidth});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isFromLeft) {
      path.addRect(Rect.fromLTWH(0, 0, clipWidth, size.height));
    } else {
      path.addRect(Rect.fromLTWH(size.width - clipWidth, 0, clipWidth, size.height));
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
