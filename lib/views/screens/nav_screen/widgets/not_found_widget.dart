
import 'package:flutter/material.dart';

class CostumeNotFoundWidget extends StatelessWidget {
  final String message;
  const CostumeNotFoundWidget({
    super.key, required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/notfound.png',
            width: 150,
            height: 150,
          ),
        ],
      ),
    );
  }
}
