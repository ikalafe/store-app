import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/product_controller.dart';
import 'package:mac_store_app/controllers/subcategory_controller.dart';
import 'package:mac_store_app/models/category_model.dart';
import 'package:mac_store_app/models/product_model.dart';
import 'package:mac_store_app/models/subcategory_model.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/not_found_widget.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/product_item_widget.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/reusable_text_widget.dart';

class InnerCategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  const InnerCategoryScreen({
    super.key,
    required this.categoryModel,
  });

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  late Future<List<SubcategoryModel>> _subcategories;
  late Future<List<ProductModel>> futureProducts;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    super.initState();
    _subcategories = _subcategoryController
        .getSubcategoriesByCategoryName(widget.categoryModel.name);
    futureProducts =
        ProductController().loadProductByCategory(widget.categoryModel.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ModalRoute.of(context)!.canPop
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 26,
                ))
            : null,
        centerTitle: true,
        title: Text(
          widget.categoryModel.name,
          style: const TextStyle(fontFamily: 'Dana'),
        ),
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              FutureBuilder(
                future: _subcategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('مشکلی پیش آمد: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: CostumeNotFoundWidget(
                          message: 'دسته بندی یافت نشد ):'),
                    );
                  } else {
                    final subcategories = snapshot.data!;
                    return SizedBox(
                      height: 160,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: subcategories.length,
                        itemBuilder: (context, index) {
                          final subcategory = subcategories[index];
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Container(
                                width: 130,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.blue.shade50,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ImageLoadingService(
                                        imageUrl: subcategory.image,
                                        widthImage: 100,
                                        heithImage: 100,
                                        imageBorderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        subcategory.subCategoryName,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const ReusableTextWidget(
                title: 'محصولات محبوب',
                subTitle: 'دیدن همه',
              ),
              FutureBuilder(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'دریافت محصولات با خطا مواجه شد: ${snapshot.error}',
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('محصول یافت نشد'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
