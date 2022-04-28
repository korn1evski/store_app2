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
