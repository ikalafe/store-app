import 'package:flutter/material.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/banner_widget.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/category_item_widget.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/header_widget.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/popular_product_widget.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/reusable_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(),
              BannerWidget(),
              CategoryItemWidget(),
              ReusableTextWidget(
                title: 'محبوب ترین محصولات',
                subTitle: 'دیدن همه',
              ),
              PopularProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
