import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/favorite_products/favorite_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';
import 'package:store_app/injection_container.dart' as di;

import 'favorite_circle.dart';

class Product extends StatefulWidget {
  final String imgPath;
  final String name;
  final String brand;
  final String price;
  final int productId;

  Product(
      {Key? key,
      required this.price,
      required this.name,
      required this.brand,
      required this.imgPath,
      required this.productId})
      : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final prefs = di.sl<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    var check = prefs.getStringList('favorites')!.contains(widget.productId.toString())
        ? true
        : false;
    return BlocConsumer(
        bloc: BlocProvider.of<FavoriteCubit>(context),
        builder: (context, state) {
          if (state is RefreshProductCardState || state is RefreshProductCardRemoveState) {
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
                          image: AssetImage(widget.imgPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: FavoriteCircle(
                          icon: check ? Icons.star : Icons.star_outline,
                          iconColor: check ? Colors.amber : Colors.black,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CommonText(
                    text: widget.name,
                    size: 16,
                    font: 'SFPRODISPLAYMEDIUM',
                    numberOfLines: 1),
                SizedBox(
                  height: 6,
                ),
                CommonText(
                  text: widget.brand,
                  size: 12,
                  color: AppColors.grey2,
                  numberOfLines: 1,
                ),
                SizedBox(
                  height: 6,
                ),
                CommonText(
                    text: '\$' + widget.price,
                    size: 16,
                    color: AppColors.green1,
                    font: 'SFPRODISPLAYMEDIUM'),
              ],
            );
          } else {
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
                          image: AssetImage(widget.imgPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: FavoriteCircle(
                          icon: check ? Icons.star : Icons.star_outline,
                          iconColor: check ? Colors.amber : Colors.black,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CommonText(
                    text: widget.name,
                    size: 16,
                    font: 'SFPRODISPLAYMEDIUM',
                    numberOfLines: 1),
                SizedBox(
                  height: 6,
                ),
                CommonText(
                  text: widget.brand,
                  size: 12,
                  color: AppColors.grey2,
                  numberOfLines: 1,
                ),
                SizedBox(
                  height: 6,
                ),
                CommonText(
                    text: '\$' + widget.price,
                    size: 16,
                    color: AppColors.green1,
                    font: 'SFPRODISPLAYMEDIUM'),
              ],
            );
          }
        },
        listener: (context, state) {
          check =
              prefs.getStringList('favorites')!.contains(widget.productId.toString())
                  ? true
                  : false;
          print('State has been changed');
        });
  }
}
