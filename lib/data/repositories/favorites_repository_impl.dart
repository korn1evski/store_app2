
import 'package:store_app/data/local/data_sources/favorites_data_source.dart';
import 'package:store_app/domain/entities/favorite_entity.dart';
import 'package:store_app/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl extends FavoritesRepository{
  final FavoritesDataSource favoritesDataSource;
  FavoritesRepositoryImpl({required this.favoritesDataSource});
  @override
  Future<int> deleteFavorite(int id) async{
    return favoritesDataSource.deleteFavorite(id);
  }

  @override
  Future<List<FavoriteEntity>> getFavorites() async{
    return favoritesDataSource.getFavorites();
  }

  @override
  Future<int> insertFavorite(FavoriteEntity favoriteEntity) async{
    return favoritesDataSource.insertFavorite(favoriteEntity);
  }
}