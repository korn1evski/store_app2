
import 'package:flutter/material.dart';

class CircleTabBarIndicator extends Decoration {
  final Color color;
  final double radius;
  const CircleTabBarIndicator({required this.color, required this.radius});
  
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;
  
  const _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;

    final Offset circleOffset = Offset(configuration.size!.width / 2 , configuration.size!.height/2 + 15);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
    
  }
}
