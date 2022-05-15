
import '../../../domain/entities/favorite_entity.dart';

abstract class FavoritesDataSource {
  Future<List<FavoriteEntity>> getFavorites();

  Future<int> insertFavorite(FavoriteEntity favoriteEntity);

  Future<int> deleteFavorite(int id);

}