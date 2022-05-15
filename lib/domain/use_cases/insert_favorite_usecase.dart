
import 'package:store_app/domain/repositories/favorites_repository.dart';

import '../entities/favorite_entity.dart';

class InsertFavoriteUseCase {
  final FavoritesRepository favoritesRepository;
  InsertFavoriteUseCase({required this.favoritesRepository});

  Future<int> call(FavoriteEntity favoriteEntity) async {
    return favoritesRepository.insertFavorite(favoriteEntity);
  }
}