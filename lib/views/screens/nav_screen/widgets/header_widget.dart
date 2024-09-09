import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 60,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffE9E9E9),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'جستجو میان هزاران محصول...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Dana',
                    fontSize: 12,
                    color: Color(0xff616161),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  prefixIcon: const Icon(Iconsax.setting_4_copy),
                  suffixIcon: const Icon(Iconsax.search_normal_copy),
                  focusColor: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 70,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                // overlayColor: WidgetStateProperty.all(const Color(0x000c7f7f)),
                onTap: () {},
                child: Ink(
                  child: const Icon(Iconsax.notification_copy),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
