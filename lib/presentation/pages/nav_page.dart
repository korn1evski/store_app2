

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/pages/account_page.dart';

import '../widgets/circle_indicator.dart';
import '../widgets/common_text.dart';
import 'main_page.dart';
import 'favorites_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> with TickerProviderStateMixin {

  @override
  void initState(){
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      BlocProvider.of<AllProductsCubit>(context).loading();
      BlocProvider.of<AllProductsCubit>(context).getInfoMain();
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
      return Scaffold(
        body: BlocBuilder<AllProductsCubit, AllProductsState>(
          builder: (context, state) {
            if(state is MainLoadingState){
              return Center(child: CircularProgressIndicator(),);
            } if (state is MainLoadedState) {
              return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                            width: double.maxFinite,
                            child: TabBarView(
                                controller: _tabController, children: [
                              MainPage(),
                              FavoritesPage(),
                              AccountPage(),
                            ])),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 30,
                                offset: Offset(0.0, 10),
                              ),
                              ]
                          ),
                          padding: EdgeInsets.only(right: 30, left: 30),
                          height: 84,
                          child: TabBar(
                            labelPadding: const EdgeInsets.only(
                                left: 20, right: 20),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black,
                            controller: _tabController,
                            isScrollable: false,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: CircleTabBarIndicator(
                                color: Colors.black, radius: 2),
                            tabs: [
                              Tab(
                                child: CommonText(
                                    text: 'Explore',
                                    size: 14,
                                    font: 'SFPRODISPLAYBOLD',
                                    color: Colors.black),
                              ),
                              Tab(
                                  icon: Icon(
                                    Icons.favorite_outline,
                                    size: 20,
                                  )),
                              Tab(
                                icon: SvgPicture.asset('img/manIcon.svg', height: 17, width: 16,)
                              ),
                            ],
                          )),
                    ],
                  )

              );
            } else{
              return Container();
            }
          }
        ),
      );
  }
}

