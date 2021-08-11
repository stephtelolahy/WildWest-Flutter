import 'dart:math';

import 'package:flutter/material.dart';

class SizeUtils {
  // Get the item width in a Row fitting screen
  static double itemWidthInARow(
      BuildContext context, int itemsCount, double maxWidth) {
    final double spacing = 2;
    final screenW = MediaQuery.of(context).size.width;
    final double availableWidth = (screenW - itemsCount * spacing) / itemsCount;
    final double result = min(availableWidth, maxWidth);
    return result;
  }
}
