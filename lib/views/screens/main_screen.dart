import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mac_store_app/theme.dart';
import 'package:mac_store_app/views/screens/nav_screen/account_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/cart_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/favorite_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/home_screen.dart';
import 'package:mac_store_app/views/screens/nav_screen/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const StoresScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];
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
          body: _pages[_pageIndex],
    );
  }
}
