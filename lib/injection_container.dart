import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source.dart';
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source_impl.dart';
import 'package:store_app/data/remote/data_sources/users_remote_data_source.dart';
import 'package:store_app/data/remote/data_sources/users_remote_data_source_impl.dart';
import 'package:store_app/data/repositories/swagger_repository_impl.dart';
import 'package:store_app/data/repositories/users_repository_impl.dart';
import 'package:store_app/domain/repositories/swagger_repository.dart';
import 'package:store_app/domain/repositories/users_repository.dart';
import 'package:store_app/domain/use_cases/get_account_info.dart';
import 'package:store_app/domain/use_cases/get_all_products_usecase.dart';
import 'package:store_app/domain/use_cases/get_categories_data_usecase.dart';
import 'package:store_app/domain/use_cases/get_product_by_id_usecase.dart';
import 'package:store_app/domain/use_cases/get_result_data_usecase.dart';
import 'package:store_app/domain/use_cases/login_usecase.dart';
import 'package:store_app/domain/use_cases/register_user_usecase.dart';
import 'package:store_app/domain/use_cases/send_review_usecase.dart';
import 'package:store_app/domain/use_cases/upload_image_usecase.dart';
import 'package:store_app/domain/use_cases/verify_login_usecase.dart';
import 'package:store_app/presentation/manager/account/account_cubit.dart';
import 'package:store_app/presentation/manager/all_favorites/all_favorites_cubit.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';
import 'package:store_app/presentation/manager/favorites_main/favorites_main_cubit.dart';
import 'package:store_app/presentation/manager/guest_review/guest_review_cubit.dart';
import 'package:store_app/presentation/manager/intro/intro_cubit.dart';
import 'package:store_app/presentation/manager/login/login_cubit.dart';
import 'package:store_app/presentation/manager/register/register_cubit.dart';
import 'package:store_app/presentation/manager/review_page/review_page_cubit.dart';
import 'package:store_app/presentation/manager/search_page/search_page_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {

  final prefs = await SharedPreferences.getInstance();

  sl.registerFactory<SearchPageCubit>(() => SearchPageCubit(getAllProductsUseCase: sl.call()));
  sl.registerFactory<AllFavoritesCubit>(() => AllFavoritesCubit(getAllProductsUseCase: sl.call()));
  sl.registerFactory<AllProductsCubit>(() => AllProductsCubit(getCategoriesDataUseCase: sl.call(), getResultDataUseCase: sl.call()));
  sl.registerFactory<FavoritesMainCubit>(() => FavoritesMainCubit());
  sl.registerFactory<DetailPageCubit>(() => DetailPageCubit(getProductByIdUseCase: sl.call(), sendReviewUseCase: sl.call()));
  sl.registerFactory<GuestReviewCubit>(() => GuestReviewCubit(uploadImageUseCase: sl.call()));
  sl.registerFactory<ReviewPageCubit>(() => ReviewPageCubit());
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(registerUserUseCase: sl.call()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUseCase: sl.call()));
  sl.registerFactory<IntroCubit>(() => IntroCubit(verifyLoginUseCase: sl.call()));
  sl.registerFactory<AccountCubit>(() => AccountCubit(verifyLoginUseCase: sl.call(), getAccountInfoUseCase: sl.call()));

  sl.registerLazySingleton<SharedPreferences>(() => prefs);

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



  sl.registerLazySingleton<SwaggerRepository>(() => SwaggerRepositoryImpl(swaggerRemoteDataSource: sl.call()));
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(usersRemoteDataSource: sl.call()));

  sl.registerLazySingleton<SwaggerRemoteDataSource>(() => SwaggerRemoteDataSourceImpl());
  sl.registerLazySingleton<UsersRemoteDataSource>(() => UsersRemoteDataSourceImpl());



}