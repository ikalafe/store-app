import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/category_controller.dart';
import 'package:mac_store_app/models/category_model.dart';
import 'package:mac_store_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/not_found_widget.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/reusable_text_widget.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  // A Future that wild hold the list of categories once loaded from the API
  late Future<List<CategoryModel>> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReusableTextWidget(title: 'دسته بندی', subTitle: 'دیدن همه'),
        FutureBuilder(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('مشکلی پیش آمد: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const CostumeNotFoundWidget(message: 'دسته بندی یافت نشد');
            } else {
              final categories = snapshot.data!;
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                padding: const EdgeInsets.only(top: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InnerCategoryScreen(
                            categoryModel: category,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ImageLoadingService(
                          imageUrl: category.image,
                          widthImage: MediaQuery.of(context).size.width * 0.27,
                          heithImage: MediaQuery.of(context).size.height * 0.12,
                          imageBorderRadius: BorderRadius.circular(12),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          category.name,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.1),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
