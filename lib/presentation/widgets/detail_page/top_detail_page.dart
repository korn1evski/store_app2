
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/injection_container.dart' as di;
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';

import '../../manager/all_favorites/all_favorites_cubit.dart';
import '../favorite_circle.dart';

class TopDetailPage extends StatefulWidget {
  final String productImg;
  final int productId;
  TopDetailPage({Key? key, required this.productImg, required this.productId}) : super(key: key);
  final prefs = di.sl<SharedPreferences>();

  @override
  State<TopDetailPage> createState() => _TopDetailPageState();
}

class _TopDetailPageState extends State<TopDetailPage> {

  @override
  Widget build(BuildContext context) {
    List<String>? mayBeNullList = widget.prefs.getStringList('favorites');
    List<String> favoritesList;
    if(mayBeNullList == null){
      favoritesList = <String>[];
    } else {
      favoritesList = mayBeNullList;
    }
        return BlocBuilder<FavoritesMainCubit, FavoritesMainState>(
          builder: (context, state) {
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
                              if(favoritesList.contains(widget.productId.toString())){
                                favoritesList.remove(widget.productId.toString());
                              } else {
                                favoritesList.add(widget.productId.toString());
                                favoritesList = favoritesList.toSet().toList();
                              }
                              if(state is RefreshProductAdded){
                                BlocProvider.of<FavoritesMainCubit>(context).refreshProductRemoved();
                              } else {
                                BlocProvider.of<FavoritesMainCubit>(context).refreshProductAdded();
                              }
                              BlocProvider.of<AllFavoritesCubit>(context).loading();
                              BlocProvider.of<AllFavoritesCubit>(context).getProducts();
                              widget.prefs.setStringList('favorites', favoritesList);
                            },

                            child: FavoriteCircle(
                              size: 40,
                              iconSize: 20,
                              icon: favoritesList.contains(widget.productId.toString()) ? Icons.star : Icons.star_outline,
                              iconColor: favoritesList.contains(widget.productId.toString()) ? Colors.amber : Colors.black,
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
        );
  }
}
