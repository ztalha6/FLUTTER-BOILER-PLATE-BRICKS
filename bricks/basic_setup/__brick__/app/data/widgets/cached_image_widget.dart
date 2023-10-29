import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key? key,
    this.url = '',
    required this.placeholder,
  }) : super(key: key);
  final String url;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fadeInDuration: 0.milliseconds,
      fadeOutDuration: 0.milliseconds,
      fit: BoxFit.cover,
      placeholder: (context, url) => placeholder,
      errorWidget: (
        context,
        url,
        error,
      ) =>
          ClipRRect(
        borderRadius: BorderRadius.circular(
          8,
        ),
        child: placeholder,
      ),
    );
  }
}
