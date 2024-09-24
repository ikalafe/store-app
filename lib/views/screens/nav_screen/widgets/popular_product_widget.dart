import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/product_controller.dart';
import 'package:mac_store_app/models/product_model.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/product_item_widget.dart';

class PopularProductWidget extends StatefulWidget {
  const PopularProductWidget({super.key});

  @override
  State<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends State<PopularProductWidget> {
  // A Future that will hold the list of popular products
  late Future<List<ProductModel>> futurePopularProduct;
  @override
  void initState() {
    super.initState();
    futurePopularProduct = ProductController().loadPopularProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futurePopularProduct,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'دریافت محصولات محبوب با خطا مواجه شد: ${snapshot.error}',
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('محصول محبوب یافت نشد'),
          );
        } else {
          final products = snapshot.data;
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: products!.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10,
                  ),
                  child: ProductItemWidget(
                    product: product,
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
