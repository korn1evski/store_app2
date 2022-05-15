
import '../entities/favorite_entity.dart';

abstract class FavoritesRepository{
  Future<List<FavoriteEntity>> getFavorites();

  Future<int> insertFavorite(FavoriteEntity favoriteEntity);

  Future<int> deleteFavorite(int id);
}