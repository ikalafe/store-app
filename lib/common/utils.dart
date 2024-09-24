import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const defuldScrollPhysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get withPriceLable => '$this تومان';
}

String convertToPersian(int number) {
  final formatter = NumberFormat.decimalPattern('fa');
  return '${formatter.format(number)} تومان';
}
