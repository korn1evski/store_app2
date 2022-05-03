import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_cases/get_all_products_usecase.dart';
import '../view_models/product_viewmodel.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit({required this.getAllProductsUseCase}) : super(SearchPageInitial());

  final GetAllProductsUseCase getAllProductsUseCase;

  late List<ProductViewModel> products;

  void getProductsForSearch() async{
    var temp = await getAllProductsUseCase.call();
    products = ProductViewModel.fromEntityList(temp);

    emit(GetProductsForSearchState(products: products));
  }

  void search(String value){
    value = value.trim();
    List<ProductViewModel> tempProducts = [];
    for(ProductViewModel productViewModel in products){
      if(productViewModel.details.toLowerCase().contains(value.toLowerCase()) || productViewModel.name.toLowerCase().contains(value.toLowerCase())){
        tempProducts.add(productViewModel);
      }
    }

    bool isAnyResult = !products.isEmpty;

    emit(SearchState(products: tempProducts, isAnyResult: isAnyResult));
  }


}
