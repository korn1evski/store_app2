part of 'search_page_cubit.dart';

abstract class SearchPageState extends Equatable {
  const SearchPageState();
}

class SearchPageInitial extends SearchPageState {
  @override
  List<Object> get props => [];
}

class GetProductsForSearchState extends SearchPageState {
  GetProductsForSearchState({required this.products});
  final products;
  @override
  List<Object> get props => [];
}

class SearchState extends SearchPageState {
  SearchState({required this.products, required this.isAnyResult});
  final products;
  final isAnyResult;
  @override
  List<Object> get props => [products, isAnyResult];
}
