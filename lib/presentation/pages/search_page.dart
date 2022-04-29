import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/search_page/search_page_cubit.dart';

import '../widgets/product.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void initState() {
    // TODO: implement initState

    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      BlocProvider.of<SearchPageCubit>(context).getProductsForSearch();
    });
  }

  TextEditingController? _textEditingController = TextEditingController();
  late var products;
  bool show = false;
  bool isAnyResult = false;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
        builder: (context, state) {
      if (state is GetProductsForSearchState) {
        products = state.products;
      }
      if(state is SearchState){
        products = state.products;
        isAnyResult = state.isAnyResult;
      }
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Container(
            height: 40,
            width: 900,
            decoration: BoxDecoration(
                color: AppColors.grey1,
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              autofocus: true,
              onChanged: (value){
                BlocProvider.of<SearchPageCubit>(context).search(value);
                show = true;
              },
              controller: _textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15, right: 15, bottom: 8),
                hintText: 'Search',
              ),
            ),
          ),
        ),
        body:   Builder(
          builder: (context) {
            if(show && isAnyResult) {
              return Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(
                                            productId: products[index].id)));
                          },
                          child: Product(
                            productId: products[index].id,
                            imgPath: products[index].mainImage,
                            name: products[index].name,
                            brand: products[index].details,
                            price: products[index].price.toInt().toString(),
                            isFavorite: false,
                            isVisible: false,
                          ));
                    }),
              );
            } else if (!isAnyResult){
              return Center(child: Text('No result'),);
            } else {
              return Center(child: Text('Search'),);
            }
          }
        ),
      );
    });
  }
}
