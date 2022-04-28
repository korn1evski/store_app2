import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/all_favorites/all_favorites_cubit.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';
import 'package:store_app/presentation/pages/nav_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AllProductsCubit>(
            create: (_) => di.sl<AllProductsCubit>(),
          ),
          BlocProvider<FavoritesMainCubit>(
            create: (context) => di.sl<FavoritesMainCubit>(),
          ),
          BlocProvider<AllFavoritesCubit>(
              create: (_) => di.sl<AllFavoritesCubit>())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyStore',
            home: NavPage()));
  }
}
