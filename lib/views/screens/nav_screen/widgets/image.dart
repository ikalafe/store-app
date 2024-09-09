import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? imageBorderRadius;
  const ImageLoadingService({
    super.key,
    required this.imageUrl,
    this.imageBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: imageBorderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) =>
            const Icon(Iconsax.gallery_remove_copy),
      ),
    );
  }
}
