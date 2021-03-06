import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/data/remote/models/id_product_model.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';
import 'package:store_app/presentation/manager/manage_favorite/manage_favorite_cubit.dart';
import 'package:store_app/presentation/manager/prefs/prefs_cubit.dart';

import '../../manager/all_favorites/all_favorites_cubit.dart';
import '../favorite_circle.dart';

class TopDetailPage extends StatefulWidget {
  final String productImg;
  final List<ImageWrapper> images;
  final int productId;
  final String details;
  final double price;
  final String name;

  TopDetailPage(
      {Key? key,
        required this.productImg,
        required this.productId,
        required this.images,
        required this.name,
        required this.details,
        required this.price
      })
      : super(key: key);

  @override
  State<TopDetailPage> createState() => _TopDetailPageState();
}

class _TopDetailPageState extends State<TopDetailPage> {
  List<String> imgList = [];
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    imgList = [];
    imgList.add(widget.productImg);
    for (var temp in widget.images) {
      imgList.add(temp.image);
    }
    List<String>? mayBeNullList = BlocProvider.of<PrefsCubit>(context).getStringList('favorites');
    List<String> favoritesList;
    if (mayBeNullList == null) {
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
                PageView.builder(
                    controller: _controller,
                    itemCount: imgList.length,
                    itemBuilder: (_, index) {
                      return CachedNetworkImage(
                        imageUrl: imgList[index],
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 477,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                )),
                          );
                        },
                        errorWidget: (context, url, error) => Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Icon(Icons.error, size: 40,),
                        ),
                      );
                    }),
                Positioned(
                    bottom: 10,
                    left: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmoothPageIndicator(
                            controller: _controller,
                            count: imgList.length,
                            effect: JumpingDotEffect(
                              activeDotColor: AppColors.green1,
                              dotColor: AppColors.shadow,
                              dotHeight: 15,
                              dotWidth: 15,
                            ),
                          ),
                        ],
                      ),
                    )),
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
                              width: 16,
                              height: 17,
                              size: 40,
                              iconSize: 20,
                              icon: 'img/arrow.svg',
                            )),
                        GestureDetector(
                          onTap: () async {
                            if (favoritesList
                                .contains(widget.productId.toString())) {
                              favoritesList.remove(widget.productId.toString());
                              BlocProvider.of<ManageFavoriteCubit>(context).deleteFavorite(widget.productId);
                            } else {
                              favoritesList.add(widget.productId.toString());
                              BlocProvider.of<ManageFavoriteCubit>(context).saveFavorite(id: widget.productId, mainImage: widget.productImg, name: widget.name, details: widget.details, price: widget.price);
                              favoritesList = favoritesList.toSet().toList();
                            }
                            if (state is RefreshProductAdded) {
                              BlocProvider.of<FavoritesMainCubit>(context)
                                  .refreshProductRemoved();
                            } else {
                              BlocProvider.of<FavoritesMainCubit>(context)
                                  .refreshProductAdded();
                            }
                            BlocProvider.of<AllFavoritesCubit>(context)
                                .getProducts();
                            BlocProvider.of<PrefsCubit>(context).setStringList('favorites', favoritesList);
                          },
                          child: FavoriteCircle(
                            width: 17,
                            height: 16,
                            size: 40,
                            iconSize: 20,
                            icon:
                            favoritesList.contains(widget.productId.toString())
                                ? 'img/fstar.svg'
                                : 'img/star.svg',
                            iconColor:
                            favoritesList.contains(widget.productId.toString())
                                ? AppColors.yellow1
                                : Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}