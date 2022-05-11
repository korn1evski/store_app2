import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/core/colors.dart';

class FavoriteCircle extends StatelessWidget {
  final double size;
  final double iconSize;
  final Color backColor;
  final String icon;
  final Color iconColor;
  final double width;
  final double height;

  const FavoriteCircle(
      {this.iconSize = 16,
      this.size = 25,
      this.backColor = Colors.white,
      this.icon = 'img/star.svg',
      Key? key,
      this.iconColor = Colors.black,
      required this.height, required this.width
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 0.5, color: AppColors.grey3),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              semanticsLabel: 'star',
              color: iconColor,
              width: width,
              height: height
            ),
          ),
        ));
  }
}
