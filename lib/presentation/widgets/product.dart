import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

import 'favorite_circle.dart';

class Product extends StatelessWidget {
  final String imgPath;
  final String name;
  final String brand;
  final String price;
  final int productId;
  final bool isFavorite;
  final bool isVisible;

  const Product(
      {Key? key,
      required this.price,
      required this.name,
      required this.brand,
      required this.imgPath,
      required this.productId,
      required this.isFavorite,
      required this.isVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imgPath,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 240,
                  width: 164,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error)
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Visibility(
                  visible: isVisible,
                  child: FavoriteCircle(
                    width: 13,
                    height: 12,
                    icon: isFavorite ? 'img/fstar.svg' : 'img/star.svg',
                    iconColor: isFavorite ? AppColors.yellow1 : Colors.black,
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        CommonText(
            text: name, size: 16, font: 'SFPRODISPLAYMEDIUM', numberOfLines: 1),
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
