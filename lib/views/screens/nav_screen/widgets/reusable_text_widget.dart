import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          width: 80,
          padding: const EdgeInsets.only(
            bottom: 1, // Space between underline and text
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.lightBlue,
                width: 1.5, // Underline thickness
              ),
            ),
          ),
          child: Center(
            child: Text(
              subTitle,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
