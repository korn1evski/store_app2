import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source.dart';
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source_impl.dart';
import 'package:store_app/data/repositories/swagger_repository_impl.dart';
import 'package:store_app/domain/repositories/swagger_repository.dart';
import 'package:store_app/domain/use_cases/get_all_products_usecase.dart';
import 'package:store_app/domain/use_cases/get_categories_data_usecase.dart';
import 'package:store_app/domain/use_cases/get_product_by_id_usecase.dart';
import 'package:store_app/domain/use_cases/get_result_data_usecase.dart';
import 'package:store_app/presentation/manager/all_favorites/all_favorites_cubit.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {

  final prefs = await SharedPreferences.getInstance();

  sl.registerFactory<AllFavoritesCubit>(() => AllFavoritesCubit(getAllProductsUseCase: sl.call()));
  sl.registerFactory<AllProductsCubit>(() => AllProductsCubit(getCategoriesDataUseCase: sl.call(), getResultDataUseCase: sl.call()));
  sl.registerFactory<FavoritesMainCubit>(() => FavoritesMainCubit());
  sl.registerFactory<DetailPageCubit>(() => DetailPageCubit(getProductByIdUseCase: sl.call()));

  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<GetResultDataUseCase>(() => GetResultDataUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCategoriesDataUseCase>(() => GetCategoriesDataUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllProductsUseCase>(() => GetAllProductsUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetProductByIdUseCase>(() => GetProductByIdUseCase(repository: sl.call()));



  sl.registerLazySingleton<SwaggerRepository>(() => SwaggerRepositoryImpl(swaggerRemoteDataSource: sl.call()));

  sl.registerLazySingleton<SwaggerRemoteDataSource>(() => SwaggerRemoteDataSourceImpl());



}