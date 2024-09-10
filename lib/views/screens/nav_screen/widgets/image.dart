import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  final double? widthImage;
  final double? heithImage;
  final BorderRadius? imageBorderRadius;
  const ImageLoadingService({
    super.key,
    required this.imageUrl,
    this.imageBorderRadius, this.widthImage, this.heithImage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: imageBorderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        width: widthImage,
        height: heithImage,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) =>
            const Icon(Iconsax.gallery_remove_copy),
      ),
    );
  }
}
