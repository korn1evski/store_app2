import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store_app/domain/entities/cached_product_entity.dart';
import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/use_cases/get_cached_categories_usecase.dart';
import 'package:store_app/domain/use_cases/get_cached_products_usecase.dart';
import 'package:store_app/domain/use_cases/get_categories_data_usecase.dart';
import 'package:store_app/domain/use_cases/get_result_data_usecase.dart';
import 'package:store_app/domain/use_cases/get_shared_string_list_usecase.dart';
import 'package:store_app/domain/use_cases/insert_cached_category_usecase.dart';
import 'package:store_app/domain/use_cases/insert_cached_product_usecase.dart';
import 'package:store_app/presentation/manager/view_models/product_viewmodel.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit(
      {required this.getCategoriesDataUseCase,
      required this.getResultDataUseCase,
      required this.getSharedStringListUseCase,
      required this.getCachedProductsUseCase,
      required this.insertCachedProductUseCase,
      required this.insertCachedCategoryUseCase,
      required this.getCachedCategoriesUseCase})
      : super(AllProductsInitial());

  final GetCategoriesDataUseCase getCategoriesDataUseCase;
  final GetCachedProductsUseCase getCachedProductsUseCase;
  final InsertCachedProductUseCase insertCachedProductUseCase;
  final GetResultDataUseCase getResultDataUseCase;
  final GetSharedStringListUseCase getSharedStringListUseCase;
  final GetCachedCategoriesUseCase getCachedCategoriesUseCase;
  final InsertCachedCategoryUseCase insertCachedCategoryUseCase;
  late var productsEntity;
  late var categories;
  late var totalPages;
  final pagination = 10;
  int currentPage = 1;

  void loading() {
    emit(MainLoadingState());
  }

  Future<void> getInfoMain() async {
    currentPage = 1;
    try {
      productsEntity = await getResultDataUseCase.call(currentPage);
      categories = await getCategoriesDataUseCase.call();
      for(var category in categories){
        await insertCachedCategoryUseCase.call(category);
      }
      totalPages = productsEntity.totalPages;
      List<ProductViewModel> products = [];
      for (var productEntity in productsEntity.products) {
        products.add(ProductViewModel(
            id: productEntity.id,
            mainImage: productEntity.mainImage,
            name: productEntity.name,
            details: productEntity.details,
            price: productEntity.price));
      }

      for (var product in products) {
        insertCachedProductUseCase.call(
            CachedProductEntity.fromProductViewModel(
                productViewModel: product));
      }

      emit(MainLoadedState(
          products: products,
          currentPage: currentPage,
          totalPages: totalPages,
          categories: categories));
    } on SocketException catch (_) {
      final List<CachedProductEntity> cachedProducts =
          await getCachedProductsUseCase.call();
      final List<ProductViewModel> productsViewModel = [];
      for (var cachedProduct in cachedProducts) {
        productsViewModel
            .add(ProductViewModel.fromCachedProductEntity(cachedProduct));
      }

      final cachedCategories = await getCachedCategoriesUseCase.call();
      if (productsViewModel.isNotEmpty) {
        categories = <CategoryEntity>[];
        totalPages = (productsViewModel.length / pagination).ceil();
        emit(MainLoadedState(
            products: productsViewModel,
            currentPage: currentPage,
            totalPages: totalPages,
            categories: cachedCategories));
      }
    }
  }

  Future<void> refreshedMain(
      List<ProductViewModel> products, currentPage) async {
    try {
      productsEntity = await getResultDataUseCase.call(currentPage);
      for (var product in productsEntity.products) {
        insertCachedProductUseCase.call(
            CachedProductEntity.fromProductEntity(productEntity: product));
      }
      for (var productEntity in productsEntity.products) {
        products.add(ProductViewModel(
            id: productEntity.id,
            mainImage: productEntity.mainImage,
            name: productEntity.name,
            details: productEntity.details,
            price: productEntity.price));
      }
      emit(MainLoadedState(
          products: products,
          currentPage: currentPage,
          totalPages: totalPages,
          categories: categories));
    } catch (e) {}
  }

  void loadingRefresher(List<ProductViewModel> products, int currentPage,
      RefreshController controller) {
    if (currentPage >= totalPages) {
      controller.loadNoData();
      return;
    } else {
      controller.loadComplete();
      currentPage++;
      refreshedMain(products, currentPage);
    }
  }

  void refreshRefresher(List<ProductViewModel> products, int currentPage,
      RefreshController controller) {
    if (products.isNotEmpty) {
      currentPage = 1;
      products.length = 10;
      controller.refreshCompleted();
      controller.resetNoData();
      getInfoMain();
    } else {
      controller.refreshFailed();
    }
  }
}
