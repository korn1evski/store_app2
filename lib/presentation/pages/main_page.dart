import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store_app/domain/entities/category_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/prefs/prefs_cubit.dart';
import 'package:store_app/presentation/manager/view_models/product_viewmodel.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';
import '../widgets/category.dart';
import '../widgets/main_page/top_main_page.dart';
import '../widgets/product.dart';
import 'detail_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin,  AutomaticKeepAliveClientMixin{
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);
  late int currentPage;
  List<ProductViewModel> products = [];
  late var totalPages;
  late var isFavorite;
  late List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: BlocBuilder<AllProductsCubit, AllProductsState>(builder: (context, state) {
          if (state is MainLoadedState) {
            totalPages = state.totalPages;
            products = state.products;
            categories = state.categories;
            currentPage = state.currentPage;
          }
            return Column(
              children: [
                Container(height: 74,),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    child: SmartRefresher(
                      enablePullUp: true,
                      controller: refreshController,
                      onRefresh: () async {
                          BlocProvider.of<AllProductsCubit>(context)
                              .refreshRefresher(products, currentPage, refreshController);
                      },
                      onLoading: () async {
                          BlocProvider.of<AllProductsCubit>(context).loadingRefresher(products, currentPage, refreshController);
                      },
                      child: ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TopMainPage(),
                              const SizedBox(
                                height: 44,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: CommonText(
                                  text: 'Categories',
                                  size: 18,
                                  font: 'SFPRODISPLAYBOLD',
                                ),
                              ),
                              SizedBox(
                                height: 19,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16),
                                width: double.maxFinite,
                                height: 105,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: CategoryWidget(
                                          text: categories[index].name,
                                          iconImg: categories[index].icon,
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonText(
                                        text: 'Best Selling', size: 18, font: 'SFPRODISPLAYBOLD'),
                                    CommonText(text: 'See all', size: 16)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 31,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16, left: 16),
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: double.maxFinite,
                                  child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: products.length,
                                      padding: EdgeInsets.all(0),
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
                                                MaterialPageRoute(builder: (context) => DetailPage(productId: products[index].id))
                                            );
                                          },
                                          child: BlocConsumer(
                                            bloc: BlocProvider.of<FavoritesMainCubit>(context),
                                            builder: (context, state) {
                                              List<String>? listString = BlocProvider.of<PrefsCubit>(context).getStringList('favorites');
                                              listString ??= <String>[];
                                              isFavorite = listString.contains(products[index].id.toString())
                                                  ? true : false;
                                              return Product(
                                                productId: products[index].id,
                                                imgPath: products[index].mainImage,
                                                name: products[index].name,
                                                brand: products[index].details,
                                                price: products[index].price.toInt().toString(),
                                                isFavorite: isFavorite,
                                                isVisible: true,
                                              );
                                            },
                                            listener: (context, state){
                                              isFavorite = BlocProvider.of<PrefsCubit>(context).isFavorite((products[index].id.toString()));
                                            },
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
        }));
  }
  @override
  bool get wantKeepAlive => true;
}