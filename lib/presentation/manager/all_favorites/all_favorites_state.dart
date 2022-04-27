part of 'all_favorites_cubit.dart';

abstract class AllFavoritesState extends Equatable {
  const AllFavoritesState();
}

class AllFavoritesInitial extends AllFavoritesState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AllFavoritesState {
  @override
  List<Object> get props => [];
}

class ProductsLoadedState extends AllFavoritesState {
  final List<ProductEntity> products;
  ProductsLoadedState({required this.products});
  @override
  List<Object> get props => [products];
}

