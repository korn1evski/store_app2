import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/data/remote/models/id_product_model.dart';
import 'package:store_app/injection_container.dart' as di;
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';

import '../../manager/all_favorites/all_favorites_cubit.dart';
import '../favorite_circle.dart';

class TopDetailPage extends StatefulWidget {
  final String productImg;
  final List<ImageWrapper> images;
  final int productId;

  TopDetailPage(
      {Key? key,
      required this.productImg,
      required this.productId,
      required this.images})
      : super(key: key);
  final prefs = di.sl<SharedPreferences>();

  @override
  State<TopDetailPage> createState() => _TopDetailPageState();
}

class _TopDetailPageState extends State<TopDetailPage> {
  List<String> imgList = [];
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    imgList.add(widget.productImg);
    for (var temp in widget.images) {
      imgList.add(temp.image);
    }
    List<String>? mayBeNullList = widget.prefs.getStringList('favorites');
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
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 477,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(imgList[index]),
                      fit: BoxFit.cover,
                    )),
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
                          size: 40,
                          iconSize: 20,
                          icon: Icons.arrow_back,
                        )),
                    GestureDetector(
                      onTap: () async {
                        if (favoritesList
                            .contains(widget.productId.toString())) {
                          favoritesList.remove(widget.productId.toString());
                        } else {
                          favoritesList.add(widget.productId.toString());
                          favoritesList = favoritesList.toSet().toList();
                        }
                        if (state is RefreshProductAdded) {
                          BlocProvider.of<FavoritesMainCubit>(context)
                              .refreshProductRemoved();
                        } else {
                          BlocProvider.of<FavoritesMainCubit>(context)
                              .refreshProductAdded();
                        }
                        BlocProvider.of<AllFavoritesCubit>(context).loading();
                        BlocProvider.of<AllFavoritesCubit>(context)
                            .getProducts();
                        widget.prefs.setStringList('favorites', favoritesList);
                      },
                      child: FavoriteCircle(
                        size: 40,
                        iconSize: 20,
                        icon:
                            favoritesList.contains(widget.productId.toString())
                                ? Icons.star
                                : Icons.star_outline,
                        iconColor:
                            favoritesList.contains(widget.productId.toString())
                                ? Colors.amber
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
