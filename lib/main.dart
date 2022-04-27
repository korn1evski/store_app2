import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source_impl.dart';
import 'package:store_app/data/repositories/swagger_repository_impl.dart';
import 'package:store_app/domain/use_cases/get_all_products_usecase.dart';
import 'package:store_app/domain/use_cases/get_categories_data_usecase.dart';
import 'package:store_app/domain/use_cases/get_result_data_usecase.dart';
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
            create: (context) => AllProductsCubit(
                getCategoriesDataUseCase: GetCategoriesDataUseCase(
                    repository: SwaggerRepositoryImpl(
                        swaggerRemoteDataSource:
                            SwaggerRemoteDataSourceImpl())),
                getResultDataUseCase: GetResultDataUseCase(
                    repository: SwaggerRepositoryImpl(
                        swaggerRemoteDataSource:
                            SwaggerRemoteDataSourceImpl()))),
          ),
          BlocProvider<FavoritesMainCubit>(
            create: (context) => FavoritesMainCubit(),
          ),
          BlocProvider<AllFavoritesCubit>(
              create: (context) => AllFavoritesCubit(
                  getAllProductsUseCase: GetAllProductsUseCase(
                      repository: SwaggerRepositoryImpl(
                          swaggerRemoteDataSource:
                              SwaggerRemoteDataSourceImpl()))))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyStore',
            home: NavPage()));
  }
}
