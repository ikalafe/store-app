import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mac_store_app/common/utils.dart';
import 'package:mac_store_app/models/product_model.dart';
import 'package:mac_store_app/views/screens/detail/product_detail_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;
  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        width: height * 0.23,
        // margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: width * 0.65,
              decoration: BoxDecoration(
                color: const Color(0xffEFF6FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ImageLoadingService(
                      imageUrl: product.images[0],
                      imageBorderRadius: BorderRadius.circular(12),
                      widthImage: 150,
                      heithImage: 150,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xffFDECEC),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Iconsax.heart_copy,
                        size: 22,
                        color: Colors.red.shade500,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Iconsax.save_2_copy,
                        size: 22,
                        color: Colors.blue.shade500,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          product.productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          convertToPersian(
                            product.productPrice,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
