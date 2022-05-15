import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/account/account_cubit.dart';
import 'package:store_app/presentation/manager/all_favorites/all_favorites_cubit.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';
import 'package:store_app/presentation/manager/guest_review/guest_review_cubit.dart';
import 'package:store_app/presentation/manager/intro/intro_cubit.dart';
import 'package:store_app/presentation/manager/login/login_cubit.dart';
import 'package:store_app/presentation/manager/manage_favorite/manage_favorite_cubit.dart';
import 'package:store_app/presentation/manager/register/register_cubit.dart';
import 'package:store_app/presentation/manager/review_page/review_page_cubit.dart';
import 'package:store_app/presentation/manager/search_page/search_page_cubit.dart';
import 'package:store_app/presentation/pages/intro_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.grey,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SearchPageCubit>(
              create: (_) => di.sl<SearchPageCubit>()),
          BlocProvider<AllProductsCubit>(
            create: (_) => di.sl<AllProductsCubit>(),
          ),
          BlocProvider<FavoritesMainCubit>(
            create: (context) => di.sl<FavoritesMainCubit>(),
          ),
          BlocProvider<AllFavoritesCubit>(
              create: (_) => di.sl<AllFavoritesCubit>()),
          BlocProvider<DetailPageCubit>(create: (_) => di.sl<DetailPageCubit>()),
          BlocProvider<GuestReviewCubit>(create: (_) => di.sl<GuestReviewCubit>()),
          BlocProvider<ReviewPageCubit>(create: (_) => di.sl<ReviewPageCubit>()),
          BlocProvider<RegisterCubit>(create: (_) => di.sl<RegisterCubit>()),
          BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
          BlocProvider<IntroCubit>(create: (_) => di.sl<IntroCubit>()),
          BlocProvider<AccountCubit>(create: (_) => di.sl<AccountCubit>()),
          BlocProvider<ManageFavoriteCubit>(create: (_) => di.sl<ManageFavoriteCubit>())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyStore',
            home: IntroPage()));
  }
}
