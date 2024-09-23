import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReusableTextWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const ReusableTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Center(
                child: Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Iconsax.arrow_left_2_copy,
                size: 20,
                color: Colors.blue,
              )
            ],
          ),
        ],
      ),
    );
  }
}
