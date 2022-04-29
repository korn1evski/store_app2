import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:store_app/domain/entities/products.entity.dart';
import 'package:store_app/domain/use_cases/get_categories_data_usecase.dart';
import 'package:store_app/domain/use_cases/get_result_data_usecase.dart';
import 'package:store_app/presentation/manager/view_models/product_viewmodel.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit({required this.getCategoriesDataUseCase, required this.getResultDataUseCase}) : super(AllProductsInitial());


  final GetCategoriesDataUseCase getCategoriesDataUseCase;
  final GetResultDataUseCase getResultDataUseCase;
  late var productsEntity;
  late final categories;
  late final totalPages;
  int currentPage = 1;

  void loading(){
    emit(MainLoadingState());
  }

  Future<void> getInfoMain() async{
    try{
      productsEntity = await getResultDataUseCase.call(currentPage);
      categories = await getCategoriesDataUseCase.call();
      totalPages = productsEntity.totalPages;
      List<ProductViewModel> products = [];
      for(var productEntity in productsEntity.products){
        products.add(ProductViewModel(id: productEntity.id, mainImage: productEntity.mainImage, name: productEntity.name, details: productEntity.details, price: productEntity.price));
      }

      emit(MainLoadedState(products: products, currentPage: currentPage, totalPages: totalPages, categories: categories));
    } catch(e) {

    }
  }

  void refreshedMain(List<ProductViewModel> products, currentPage) async{
    try {
      productsEntity = await getResultDataUseCase.call(currentPage);
      for (var productEntity in productsEntity.products) {
        products.add(ProductViewModel(id: productEntity.id,
            mainImage: productEntity.mainImage,
            name: productEntity.name,
            details: productEntity.details,
            price: productEntity.price));
      }
      emit(MainLoadedState(products: products,
          currentPage: currentPage,
          totalPages: totalPages,
          categories: categories));
    } catch(e){

    }
  }


}
