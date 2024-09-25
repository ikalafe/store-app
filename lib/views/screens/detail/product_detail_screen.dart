import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mac_store_app/common/utils.dart';
import 'package:mac_store_app/models/product_model.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(color: Colors.blue.shade50),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'افزودن به سبد خرید',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  convertToPersian(widget.product.productPrice),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: ModalRoute.of(context)!.canPop
            ? Expanded(
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.20,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: widget.product.images.length,
                      itemBuilder: (context, index) {
                        return ImageLoadingService(
                          imageUrl: widget.product.images[index],
                          heithImage: MediaQuery.of(context).size.height * 0.50,
                          imageBorderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: 145,
                      right: 145,
                      bottom: 0,
                      child: Container(
                        width: 101,
                        height: 13,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: widget.product.images.length,
                            axisDirection: Axis.horizontal,
                            effect: const ExpandingDotsEffect(
                              paintStyle: PaintingStyle.fill,
                              dotColor: Color(0xffB6D6FD),
                              activeDotColor: Color(0xff4475B2),
                              spacing: 3.0,
                              dotHeight: 4,
                              radius: 4,
                              dotWidth: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        widget.product.productName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.archive_1_copy,
                          color: Colors.blue.shade900,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Icon(
                          Iconsax.heart_copy,
                          color: Colors.red.shade600,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              /*
              Category
              */
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 20),
                  child: Row(
                    children: [
                      Text(
                        'در دسته بندی: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.blue.shade500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.product.category,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /*
              Description
              */
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'توضیحات محصول',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.product.description,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
