
import 'package:store_app/domain/entities/favorite_entity.dart';
import 'package:store_app/domain/repositories/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository favoritesRepository;

  GetFavoritesUseCase({required this.favoritesRepository});

  Future<List<FavoriteEntity>> call() async{
    return favoritesRepository.getFavorites();
  }
}