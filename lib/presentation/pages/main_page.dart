import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/domain/use_cases/get_result_data_usecase.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/view_models/product_viewmodel.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';
import '../widgets/category.dart';
import '../widgets/main_page/top_main_page.dart';
import '../widgets/product.dart';
import 'detail_page.dart';
import 'package:store_app/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin,  AutomaticKeepAliveClientMixin{
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);
  int currentPage = 1;
  List<ProductViewModel> products = [];
  var prefs = di.sl<SharedPreferences>();
  late var isFavorite;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: BlocBuilder<AllProductsCubit, AllProductsState>(builder: (context, state) {
          if (state is MainLoadedState) {
            var totalPages = state.totalPages;
            if (currentPage == 1) {
              products = state.products;
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
                        if (products.isNotEmpty) {
                          currentPage = 1;
                          products.length = 10;
                          refreshController.refreshCompleted();
                          refreshController.resetNoData();
                          BlocProvider.of<AllProductsCubit>(context)
                              .refreshedMain(products, currentPage);
                        } else {
                          refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        if (currentPage >= totalPages) {
                          refreshController.loadNoData();
                          return;
                        } else {
                          currentPage++;
                          var productsResponse =
                          await di.sl<GetResultDataUseCase>().call(currentPage);
                          List<ProductViewModel> productsTemp = ProductViewModel.fromEntityList(productsResponse.products);
                          if (productsTemp.isNotEmpty) {
                            products.addAll(productsTemp);
                            refreshController.loadComplete();
                            BlocProvider.of<AllProductsCubit>(context)
                                .refreshedMain(products, currentPage);
                          } else {
                            refreshController.loadFailed();
                          }
                        }
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
                                    itemCount: state.categories.length,
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: CategoryWidget(
                                          text: state.categories[index].name,
                                          iconImg: state.categories[index].icon,
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
                                              List<String>? listString = prefs.getStringList('favorites');
                                              if( listString == null){
                                                listString = <String>[];
                                              }
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
                                              isFavorite =
                                              prefs.getStringList('favorites')!.contains(products[index].id.toString())
                                                  ? true
                                                  : false;
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
          } else {
            return Container();
          }
        }));
  }
  @override
  bool get wantKeepAlive => true;
}