import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/product_controller.dart';
import 'package:mac_store_app/models/product_model.dart';

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
          return ListView.builder(
            itemCount: products!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final product = products[index];
              return Text(product.productName);
            },
          );
        }
      },
    );
  }
}
