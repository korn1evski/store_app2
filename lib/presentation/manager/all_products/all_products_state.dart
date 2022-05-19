part of 'all_products_cubit.dart';

abstract class AllProductsState extends Equatable {
  const AllProductsState();
}

class AllProductsInitial extends AllProductsState {
  @override
  List<Object> get props => [];
}

class MainLoadingState extends AllProductsState {
  @override
  List<Object?> get props => [];

}

class MainLoadedState extends AllProductsState {
  final List<ProductViewModel> products;
  final List<CategoryEntity> categories;
  final int currentPage;
  final int totalPages;
  const MainLoadedState({required this.products, required this.currentPage, required this.totalPages, required this.categories});

  @override
  List<Object?> get props => [products, currentPage, categories];

}
