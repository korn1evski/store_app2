import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:store_app/domain/use_cases/get_all_products_usecase.dart';
import 'package:store_app/injection_container.dart' as di;

part 'all_favorites_state.dart';

class AllFavoritesCubit extends Cubit<AllFavoritesState> {
  AllFavoritesCubit({required this.getAllProductsUseCase}) : super(AllFavoritesInitial());
  final GetAllProductsUseCase getAllProductsUseCase;

  late var products;
  var prefs = di.sl<SharedPreferences>();

  void loading(){
    emit(LoadingState());
  }

  Future<void> getProducts() async{
    try{
      products = await getAllProductsUseCase.call();
      List<String>? favoriteIds = prefs.getStringList('favorites');
      if(favoriteIds == null) {
        emit(ProductsLoadedState(products: <ProductEntity>[]));
      } else {
        List<ProductEntity> favoriteProducts = <ProductEntity>[];
        for (var product in products){
          if(favoriteIds.contains(product.id.toString())){
            favoriteProducts.add(product);
          }
        }
        emit(ProductsLoadedState(products: favoriteProducts));
      }
    } catch(e){

    }
  }


}
