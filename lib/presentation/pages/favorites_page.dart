import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/all_favorites/all_favorites_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

import '../../domain/entities/product_entity.dart';
import '../widgets/product.dart';
import 'detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      BlocProvider.of<AllFavoritesCubit>(context).loading();
      BlocProvider.of<AllFavoritesCubit>(context).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllFavoritesCubit, AllFavoritesState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ProductsLoadedState) {
        var products = state.products;
        if(products.isNotEmpty){
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 74, bottom: 50),
                child: CommonText(
                  text: 'Favorite products',
                  size: 18,
                  font: 'SFPRODISPLAYBOLD',
                ),
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: products.length,
                    padding: EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 6,
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             DetailPage(product: products[index])));
                          },
                          child: Product(
                            productId: products[index].id,
                            imgPath: products[index].mainImage,
                            name: products[index].name,
                            brand: products[index].details,
                            price: products[index].price.toInt().toString(),
                            isFavorite: true,
                          ));
                    }),
              ),
            ],
          ),
        );}
        else {
          return Center(child: Text('No favorite products yet'));
        }
      } else {
        return Container();
      }
    });
  }
}
