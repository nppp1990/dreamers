import 'package:dreamer/common/widget/base_normal_page.dart';
import 'package:dreamer/common/widget/loading.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlockListPage extends StatelessWidget {
  const BlockListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NormalPage(
      title: 'Blocklist',
      child: _BlockListContent(),
    );
  }
}

class Info {
  final String id;
  final String name;
  final String avatar;
  final String desc;

  Info({required this.id, required this.name, required this.avatar, required this.desc});
}

class _BlockListContent extends StatefulWidget {
  const _BlockListContent();

  @override
  _BlockListContentState createState() => _BlockListContentState();
}

class _BlockListContentState extends State<_BlockListContent> {
  late List<Info>? _data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    // mock 1s delay get data
    _data = null;
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _data = [
        Info(
          id: '1',
          name: 'Alice',
          avatar: 'https://img0.baidu.com/it/u=1032205497,3282975304&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
          desc: 'I am Alice, nice to meet you',
        ),
        Info(
            id: '2',
            name: 'Bob',
            avatar: 'https://img2.baidu.com/it/u=3695854868,3440488427&fm=253&fmt=auto&app=138&f=JPEG?w=683&h=684',
            desc: 'I am Bob, nice to meet you'),
        Info(
            id: '3',
            name: 'Charlie',
            avatar: 'https://lmg.jj20.com/up/allimg/tx29/081511214242611372.jpg',
            desc: 'I am Charlie'),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Loading(
      type: _data == null ? LoadingType.empty : LoadingType.success,
      builder: _buildList,
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
          itemCount: _data!.length,
          itemBuilder: (context, index) {
            var item = _data![index];
            return SizedBox(
              height: 64,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFFE0E0E0),
                    backgroundImage: NetworkImage(item.avatar),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        item.desc,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1,
                          color: Color(0xFF9B9B9B),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _data!.removeAt(index);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/images/icons/ic_remove_user.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          DreamerColors.primary,
                          BlendMode.srcIn,
                        )
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
