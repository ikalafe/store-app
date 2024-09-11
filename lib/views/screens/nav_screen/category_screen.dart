import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/category_controller.dart';
import 'package:mac_store_app/controllers/subcategory_controller.dart';
import 'package:mac_store_app/models/category_model.dart';
import 'package:mac_store_app/models/subcategory_model.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/header_widget.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/not_found_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // A Future that wild hold the list of categories once loaded from the API
  late Future<List<CategoryModel>> futureCategories;
  CategoryModel? _selectedCategory;
  List<SubcategoryModel> _subcategories = [];
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategory();
    // Once the Categories are loaded proccess then
    futureCategories.then((categories) {
      // Iterate through categories to find the "کفش مردانه" category
      for (var category in categories) {
        if (category.name == "کفش مردانه") {
          // if "کفش مردانه" category is found, set it as the selected category
          setState(() {
            _selectedCategory = category;
          });
          // Load subcategories for the "کفش مردانه" category
          _loadSubcategories(category.name);
        }
      }
    });
  }

  // Load Subcategories base on the categoryName
  Future<void> _loadSubcategories(String categoryName) async {
    final subcategories = await _subcategoryController
        .getSubcategoriesByCategoryName(categoryName);
    setState(() {
      _subcategories = subcategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
        child: const HeaderWidget(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Right side - Display categories
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 78, 156, 252),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: FutureBuilder(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'مشکلی در باگزاری دسته بندی رخ داد ): ${snapshot.error}',
                      ),
                    );
                  } else {
                    final categories = snapshot.data;
                    return ListView.builder(
                      itemCount: categories!.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _loadSubcategories(category.name);
                          },
                          title: Container(
                            width: 80,
                            height: _selectedCategory == category ? 50 : null,
                            decoration: BoxDecoration(
                              borderRadius: _selectedCategory == category
                                  ? BorderRadius.circular(12)
                                  : null,
                              color: _selectedCategory == category
                                  ? const Color.fromARGB(255, 11, 18, 162)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Dana',
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          // Left Side - Display slelected cateogry detailes
          Expanded(
            flex: 6,
            child: _selectedCategory != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'دسته بندی: ${_selectedCategory!.name}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _subcategories.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: _subcategories.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 2 / 2,
                                ),
                                itemBuilder: (context, index) {
                                  final subcategory = _subcategories[index];
                                  debugPrint('$subcategory');
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffEFF6FF),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        width: 110,
                                        height: 120,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ImageLoadingService(
                                              imageUrl: subcategory.image,
                                              widthImage: 80,
                                              heithImage: 80,
                                              imageBorderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              subcategory.subCategoryName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            : const CostumeNotFoundWidget(
                                message: 'زیر مجموعه دسته بندی یافت نشد.',
                              ),
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
