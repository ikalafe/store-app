import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mac_store_app/theme.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xffEFF6FF),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: LightThemeColors.primaryColor,
          unselectedItemColor: Colors.black,
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  _pageIndex == 0 ? Iconsax.home_2 : Iconsax.home_2_copy,
                  // color: Colors.black,
                  size: 25,
                ),
                label: 'خانه'),
            BottomNavigationBarItem(
              icon: Icon(
                _pageIndex == 1 ? Iconsax.heart : Iconsax.heart_copy,
                size: 25,
              ),
              label: 'علاقه مندی',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _pageIndex == 2 ? Iconsax.bag_2 : Iconsax.bag_2_copy,
                size: 25,
              ),
              label: 'فروشگاه',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _pageIndex == 3 ? Iconsax.bag : Iconsax.bag_copy,
                size: 25,
              ),
              label: 'سبد خرید',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _pageIndex == 4 ? Iconsax.user : Iconsax.user_copy,
                size: 25,
              ),
              label: 'پروفایل',
            ),
          ]),
    );
  }
}
