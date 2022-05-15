import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app/data/local/data_bases/shop_db.dart';
import 'package:store_app/domain/entities/favorite_entity.dart';
import 'package:store_app/domain/use_cases/get_all_products_usecase.dart';
import 'package:store_app/domain/use_cases/get_favorites_usecase.dart';
part 'all_favorites_state.dart';

class AllFavoritesCubit extends Cubit<AllFavoritesState> {
  AllFavoritesCubit({required this.getFavoritesUseCase}) : super(AllFavoritesInitial());
  final GetFavoritesUseCase getFavoritesUseCase;

  late dynamic products;
  Future<void> getProducts() async {
    try {
      products = await getFavoritesUseCase.call();
      if (products == null) {
        emit(ProductsLoadedState(products: <FavoriteEntity>[]));
      } else {
        emit(ProductsLoadedState(products: products));
      }
    } catch(e){

    }
  }
}
