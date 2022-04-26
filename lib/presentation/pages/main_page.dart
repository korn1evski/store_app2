

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/domain/use_cases/get_result_data_usecase.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

import '../../data/remote/data_sources/swagger_remote_data_source_impl.dart';
import '../../data/repositories/swagger_repository_impl.dart';
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
  int currentPage = 1;
  List<ProductEntity> products = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        body: BlocBuilder<AllProductsCubit, AllProductsState>(builder: (context, state) {
          if (state is MainLoadedState) {
            var totalPages = state.totalPages;
            if (currentPage == 1) {
              products = state.products;
            }
            return Column(
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Container(
                      padding: EdgeInsets.all(0),
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
                            await GetResultDataUseCase(repository: SwaggerRepositoryImpl(swaggerRemoteDataSource: SwaggerRemoteDataSourceImpl())).call(currentPage);
                            List<ProductEntity> productsTemp = productsResponse.products;
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
                                      MaterialPageRoute(builder: (context) => DetailPage(product: products[index]))
                                  );
                                },
                                child: Product(
                                  productId: products[index].id,
                                  imgPath: ProductEntity.properImage(products[index].category.name),
                                  name: products[index].name,
                                  brand: products[index].details,
                                  price: products[index].price.toInt().toString(),
                                ),
                              );
                            }),
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
