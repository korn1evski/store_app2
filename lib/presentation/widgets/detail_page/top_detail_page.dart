
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/injection_container.dart' as di;
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/favorite_products/favorite_cubit.dart';

import '../favorite_circle.dart';

class TopDetailPage extends StatefulWidget {
  final String productImg;
  final int productId;
  const TopDetailPage({Key? key, required this.productImg, required this.productId}) : super(key: key);

  @override
  State<TopDetailPage> createState() => _TopDetailPageState();
}

class _TopDetailPageState extends State<TopDetailPage> {
  final prefs = di.sl<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 477,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 477,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(widget.productImg),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            top: 74,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: FavoriteCircle(
                        size: 40,
                        iconSize: 20,
                        icon: Icons.arrow_back,
                      )),
                  GestureDetector(
                    onTap: () async{
                      List<String>? newList = prefs.getStringList('favorites');
                      if(newList == null){
                        newList = <String>[];
                      }
                      if(newList.contains(widget.productId.toString())){
                        newList.remove(widget.productId.toString());
                        BlocProvider.of<FavoriteCubit>(context).refreshProductCardRemove();
                      } else {
                        newList.add(widget.productId.toString());
                        newList = newList.toSet().toList();
                        BlocProvider.of<FavoriteCubit>(context).refreshProductCard();
                      }
                      setState(() {

                      });
                      prefs.setStringList('favorites', newList);
                      print(prefs.getStringList('favorites'));
                    },

                    child: FavoriteCircle(
                      size: 40,
                      iconSize: 20,
                      icon: prefs.getStringList('favorites')!.contains(widget.productId.toString()) ? Icons.star : Icons.star_outline,
                      iconColor: prefs.getStringList('favorites')!.contains(widget.productId.toString()) ? Colors.amber : Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
