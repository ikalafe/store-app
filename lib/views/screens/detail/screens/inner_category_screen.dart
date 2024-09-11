import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/subcategory_controller.dart';
import 'package:mac_store_app/models/category_model.dart';
import 'package:mac_store_app/models/subcategory_model.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/not_found_widget.dart';

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
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    super.initState();
    _subcategories = _subcategoryController
        .getSubcategoriesByCategoryName(widget.categoryModel.name);
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
                    child:
                        CostumeNotFoundWidget(message: 'دسته بندی یافت نشد ):'),
                  );
                } else {
                  final subcategories = snapshot.data!;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subcategories.length,
                    padding: const EdgeInsets.only(top: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 40,
                    ),
                    itemBuilder: (context, index) {
                      final subcategory = subcategories[index];
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xff4475B2),
                                  blurRadius: 6,
                                  offset: Offset(1, 1), // Shadow position
                                ),
                              ],
                              color: const Color(0xffB6D6FD),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageLoadingService(
                                  imageUrl: subcategory.image,
                                  widthImage: 120,
                                  heithImage: 120,
                                  imageBorderRadius: BorderRadius.circular(12),
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
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
