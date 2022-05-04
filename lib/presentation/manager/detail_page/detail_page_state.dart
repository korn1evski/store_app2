part of 'detail_page_cubit.dart';

abstract class DetailPageState extends Equatable {
  const DetailPageState();
}

class DetailPageInitial extends DetailPageState {
  @override
  List<Object> get props => [];
}

class LoadingDetailState extends DetailPageState {
  @override
  List<Object> get props => [];
}
class ProductLoadedState extends DetailPageState {
  final product;
  ProductLoadedState({required this.product});
  @override
  List<Object> get props => [product];
}

class ProductUpdatedState extends DetailPageState {
  final product;
  final String firstName;
  final String lastName;
  ProductUpdatedState({required this.product, required this.firstName, required this.lastName});
  @override
  List<Object> get props => [product, firstName, lastName];
}
