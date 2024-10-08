import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/models/category_model.dart';

class CategoryProvider extends StateNotifier<List<CategoryModel>> {
  CategoryProvider() : super([]);

  // Set the list of categories
  void setCategories(List<CategoryModel> categories) {
    state = categories;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<CategoryModel>>((ref) {
  return CategoryProvider();
});
