import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/data/local/data_bases/shop_db.dart';
import 'package:store_app/data/local/data_sources/auth_remote_data_source.dart';
import 'package:store_app/data/local/data_sources/auth_remote_data_source_impl.dart';
import 'package:store_app/data/local/data_sources/cached_products_dao.dart';
import 'package:store_app/data/local/data_sources/cached_products_data_source.dart';
import 'package:store_app/data/local/data_sources/favorite_dao.dart';
import 'package:store_app/data/local/data_sources/favorites_data_source.dart';
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source.dart';
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source_impl.dart';
import 'package:store_app/data/remote/data_sources/users_remote_data_source.dart';
import 'package:store_app/data/remote/data_sources/users_remote_data_source_impl.dart';
import 'package:store_app/data/repositories/auth_repository_impl.dart';
import 'package:store_app/data/repositories/cached_products_repository_impl.dart';
import 'package:store_app/data/repositories/favorites_repository_impl.dart';
import 'package:store_app/data/repositories/swagger_repository_impl.dart';
import 'package:store_app/data/repositories/users_repository_impl.dart';
import 'package:store_app/domain/repositories/auth_repository.dart';
import 'package:store_app/domain/repositories/cached_products_repository.dart';
import 'package:store_app/domain/repositories/favorites_repository.dart';
import 'package:store_app/domain/repositories/swagger_repository.dart';
import 'package:store_app/domain/repositories/users_repository.dart';
import 'package:store_app/domain/use_cases/delete_favorite_usecase.dart';
import 'package:store_app/domain/use_cases/get_account_info.dart';
import 'package:store_app/domain/use_cases/get_all_products_usecase.dart';
import 'package:store_app/domain/use_cases/get_cached_products_usecase.dart';
import 'package:store_app/domain/use_cases/get_categories_data_usecase.dart';
import 'package:store_app/domain/use_cases/get_favorites_usecase.dart';
import 'package:store_app/domain/use_cases/get_product_by_id_usecase.dart';
import 'package:store_app/domain/use_cases/get_result_data_usecase.dart';
import 'package:store_app/domain/use_cases/get_shared_string_list_usecase.dart';
import 'package:store_app/domain/use_cases/get_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/insert_cached_product_usecase.dart';
import 'package:store_app/domain/use_cases/insert_favorite_usecase.dart';
import 'package:store_app/domain/use_cases/login_usecase.dart';
import 'package:store_app/domain/use_cases/register_user_usecase.dart';
import 'package:store_app/domain/use_cases/send_review_usecase.dart';
import 'package:store_app/domain/use_cases/set_shared_string_list_usecase.dart';
import 'package:store_app/domain/use_cases/set_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/upload_image_usecase.dart';
import 'package:store_app/domain/use_cases/verify_login_usecase.dart';
import 'package:store_app/presentation/manager/account/account_cubit.dart';
import 'package:store_app/presentation/manager/all_favorites/all_favorites_cubit.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/controllers/feedback_controller.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';
import 'package:store_app/presentation/manager/feed_back/feedback_cubit.dart';
import 'package:store_app/presentation/manager/guest_review/guest_review_cubit.dart';
import 'package:store_app/presentation/manager/intro/intro_cubit.dart';
import 'package:store_app/presentation/manager/login/login_cubit.dart';
import 'package:store_app/presentation/manager/manage_favorite/manage_favorite_cubit.dart';
import 'package:store_app/presentation/manager/prefs/prefs_cubit.dart';
import 'package:store_app/presentation/manager/register/register_cubit.dart';
import 'package:store_app/presentation/manager/search_page/search_page_cubit.dart';
import 'package:get/get.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {

  final prefs = await SharedPreferences.getInstance();
  final authDio = Dio();



  sl.registerFactory<SearchPageCubit>(() => SearchPageCubit(getAllProductsUseCase: sl.call()));
  sl.registerFactory<AllFavoritesCubit>(() => AllFavoritesCubit(getFavoritesUseCase: sl.call()));
  sl.registerFactory<AllProductsCubit>(() => AllProductsCubit(getCategoriesDataUseCase: sl.call(), getResultDataUseCase: sl.call(), getSharedStringListUseCase: sl.call(), insertCachedProductUseCase: sl.call(), getCachedProductsUseCase: sl.call()));
  sl.registerFactory<FavoritesMainCubit>(() => FavoritesMainCubit());
  sl.registerFactory<DetailPageCubit>(() => DetailPageCubit(getProductByIdUseCase: sl.call(), sendReviewUseCase: sl.call(), getAccountInfoUseCase: sl.call(), getSharedStringUseCase: sl.call(), verifyLoginUseCase: sl.call()));
  sl.registerFactory<GuestReviewCubit>(() => GuestReviewCubit(uploadImageUseCase: sl.call()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(registerUserUseCase: sl.call(), uploadImageUseCase: sl.call()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUseCase: sl.call()));
  sl.registerFactory<IntroCubit>(() => IntroCubit(verifyLoginUseCase: sl.call(), setSharedStringUseCase: sl.call(), getSharedStringUseCase: sl.call()));
  sl.registerFactory<AccountCubit>(() => AccountCubit(verifyLoginUseCase: sl.call(), getAccountInfoUseCase: sl.call(), getSharedStringUseCase: sl.call(), setSharedStringUseCase: sl.call()));
  sl.registerFactory<ManageFavoriteCubit>(() => ManageFavoriteCubit(deleteFavoriteUseCase: sl.call(), insertFavoriteUseCase: sl.call()));
  sl.registerFactory<FeedbackCubit>(() => FeedbackCubit());
  sl.registerFactory<PrefsCubit>(() => PrefsCubit(getSharedStringListUseCase: sl.call(), getSharedStringUseCase: sl.call(), setSharedStringListUseCase: sl.call()));

  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<Dio>(() => authDio);
  sl.registerLazySingleton<ShopDb>(() => ShopDb());

  Get.lazyPut(() => FeedBackController());

  sl.registerLazySingleton<GetResultDataUseCase>(() => GetResultDataUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCategoriesDataUseCase>(() => GetCategoriesDataUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllProductsUseCase>(() => GetAllProductsUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetProductByIdUseCase>(() => GetProductByIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendReviewUseCase>(() => SendReviewUseCase(repository: sl.call()));
  sl.registerLazySingleton<UploadImageUseCase>(() => UploadImageUseCase(repository: sl.call()));
  sl.registerLazySingleton<RegisterUserUseCase>(() => RegisterUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyLoginUseCase>(() => VerifyLoginUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAccountInfoUseCase>(() => GetAccountInfoUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetSharedStringUseCase>(() => GetSharedStringUseCase(repository: sl.call()));
  sl.registerLazySingleton<SetSharedStringUseCase>(() => SetSharedStringUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteFavoriteUseCase>(() => DeleteFavoriteUseCase(favoritesRepository: sl.call()));
  sl.registerLazySingleton<InsertFavoriteUseCase>(() => InsertFavoriteUseCase(favoritesRepository: sl.call()));
  sl.registerLazySingleton<GetFavoritesUseCase>(() => GetFavoritesUseCase(favoritesRepository: sl.call()));
  sl.registerLazySingleton<GetSharedStringListUseCase>(() => GetSharedStringListUseCase(authRepository: sl.call()));
  sl.registerLazySingleton<SetSharedStringListUseCase>(() => SetSharedStringListUseCase(authRepository: sl.call()));
  sl.registerLazySingleton<GetCachedProductsUseCase>(() => GetCachedProductsUseCase(cachedProductsRepository: sl.call()));
  sl.registerLazySingleton<InsertCachedProductUseCase>(() => InsertCachedProductUseCase(cachedProductsRepository: sl.call()));

  sl.registerLazySingleton<SwaggerRepository>(() => SwaggerRepositoryImpl(swaggerRemoteDataSource: sl.call()));
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(usersRemoteDataSource: sl.call()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: sl.call()));
  sl.registerLazySingleton<FavoritesRepository>(() => FavoritesRepositoryImpl(favoritesDataSource: sl.call()));
  sl.registerLazySingleton<CachedProductsRepository>(() => CachedProductsRepositoryImpl(cachedProductsDataSource: sl.call()));

  sl.registerLazySingleton<SwaggerRemoteDataSource>(() => SwaggerRemoteDataSourceImpl());
  sl.registerLazySingleton<UsersRemoteDataSource>(() => UsersRemoteDataSourceImpl(authDio: authDio));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<FavoritesDataSource>(() => FavoriteDao(sl.call()));
  sl.registerLazySingleton<CachedProductsDataSource>(() => CachedProductsDao(sl.call()));


  configureAuthDio(dio: authDio, getSharedStringUseCase: sl.call());
}

void configureAuthDio({required Dio dio, required GetSharedStringUseCase getSharedStringUseCase}) async{
  dio.interceptors.clear();

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    final accessToken = getSharedStringUseCase.call('accessToken');
    if (accessToken != null || accessToken != '') {
      options.headers['Authorization'] =
          'Token $accessToken';
      return handler.next(options);
    } else {
      return handler.next(options);
    }
  }));
}