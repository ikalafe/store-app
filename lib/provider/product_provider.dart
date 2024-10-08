import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/models/product_model.dart';

class ProductProvider extends StateNotifier<List<ProductModel>> {
  ProductProvider() : super([]);

  // Set the list of products
  void setProducts(List<ProductModel> products) {
    state = products;
  }
}

final productProvider =
    StateNotifierProvider<ProductProvider, List<ProductModel>>(
  (ref) {
    return ProductProvider();
  },
);
