import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/category_controller.dart';
import 'package:mac_store_app/models/category_model.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';

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
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('مشکلی پیش آمد: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('دسته بندی یافت نشد'));
        } else {
          final categories = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Padding(
                padding: EdgeInsets.only(right: 25.0, top: 20),
                child: Text(
                  'دسته بندی',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Column(
                    children: [
                      ImageLoadingService(
                        imageUrl: category.image,
                        widthImage: 95,
                        heithImage: 95,
                        imageBorderRadius: BorderRadius.circular(12),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(category.name),
                    ],
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
