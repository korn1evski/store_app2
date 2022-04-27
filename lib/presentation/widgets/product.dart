import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

import 'favorite_circle.dart';

class Product extends StatelessWidget {
  final String imgPath;
  final String name;
  final String brand;
  final String price;
  final int productId;
  final bool isFavorite;

  const Product(
      {Key? key,
        required this.price,
        required this.name,
        required this.brand,
        required this.imgPath,
        required this.productId,
        required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 240,
              width: 164,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: FavoriteCircle(
                  icon: isFavorite ? Icons.star : Icons.star_outline,
                  iconColor: isFavorite ? Colors.amber : Colors.black,
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        CommonText(
            text: name,
            size: 16,
            font: 'SFPRODISPLAYMEDIUM',
            numberOfLines: 1),
        SizedBox(
          height: 6,
        ),
        CommonText(
          text: brand,
          size: 12,
          color: AppColors.grey2,
          numberOfLines: 1,
        ),
        SizedBox(
          height: 6,
        ),
        CommonText(
            text: '\$' + price,
            size: 16,
            color: AppColors.green1,
            font: 'SFPRODISPLAYMEDIUM'),
      ],
    );
  }
}

