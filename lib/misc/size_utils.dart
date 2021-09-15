import 'package:flutter/material.dart';

class SizeUtils {
  static const ITEM_SPACING = 2.0;

  static double maxItemWidthInARow(BuildContext context, int itemsCount) {
    final screenW = MediaQuery.of(context).size.width;
    return (screenW - itemsCount * ITEM_SPACING) / itemsCount;
  }
}

extension Positionning on GlobalKey {
  Offset center() {
    final box = this.currentContext?.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final centerX = offset.dx + box.size.width / 2;
    final centerY = offset.dy + box.size.height / 2;
    return Offset(centerX, centerY);
  }

  Offset offset() {
    final box = this.currentContext?.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero);
  }
}
