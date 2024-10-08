import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/controllers/category_controller.dart';
import 'package:mac_store_app/provider/category_provider.dart';
import 'package:mac_store_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/reusable_text_widget.dart';

class CategoryItemWidget extends ConsumerStatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  ConsumerState<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends ConsumerState<CategoryItemWidget> {
  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final CategoryController categoryController = CategoryController();
    try {
      final categories = await categoryController.loadCategory();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      children: [
        const ReusableTextWidget(title: 'دسته بندی', subTitle: 'دیدن همه'),
        GridView.builder(
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
        )
      ],
    );
  }
}
