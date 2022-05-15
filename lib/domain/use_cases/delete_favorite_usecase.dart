
import 'package:store_app/domain/repositories/favorites_repository.dart';

class DeleteFavoriteUseCase {
  final FavoritesRepository favoritesRepository;
  DeleteFavoriteUseCase({required this.favoritesRepository});

  Future<int> call(int id) async {
    return favoritesRepository.deleteFavorite(id);
  }
}