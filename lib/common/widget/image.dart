import 'package:cached_network_image/cached_network_image.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final ImageWidgetBuilder? imageBuilder;
  final PlaceholderWidgetBuilder? placeholder;
  final bool showProgress;
  final BoxFit? fit;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.imageBuilder,
    this.placeholder,
    this.showProgress = true,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: imageBuilder,
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: placeholder ??
          (context, url) => Container(
                width: width,
                height: height,
                color: DreamerColors.grey300,
                child: showProgress ? const Center(child: CircularProgressIndicator()) : null,
              ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: DreamerColors.grey300,
        child: const Center(child: Icon(Icons.broken_image_outlined)),
      ),
    );
  }
}
