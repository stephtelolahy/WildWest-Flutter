import 'package:flutter/material.dart';

class SizeUtils {
  static double maxItemWidthInARow(BuildContext context, int itemsCount) {
    final double spacing = 2;
    final screenW = MediaQuery.of(context).size.width;
    return (screenW - itemsCount * spacing) / itemsCount;
  }
}
