import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/domain/entities/favorite_entity.dart';
import 'package:store_app/domain/use_cases/delete_favorite_usecase.dart';
import 'package:store_app/domain/use_cases/insert_favorite_usecase.dart';

import '../../../data/local/data_bases/shop_db.dart';

import 'package:drift/drift.dart' as drift;

import '../../../domain/use_cases/get_favorites_usecase.dart';

part 'manage_favorite_state.dart';

class ManageFavoriteCubit extends Cubit<ManageFavoriteState> {
  ManageFavoriteCubit(
      {required this.deleteFavoriteUseCase,
      required this.insertFavoriteUseCase})
      : super(ManageFavoriteInitial());

  final DeleteFavoriteUseCase deleteFavoriteUseCase;
  final InsertFavoriteUseCase insertFavoriteUseCase;

  void saveFavorite(
      {required int id,
      required String mainImage,
      required String name,
      required String details,
      required double price}) async {
    final favoriteEntity = FavoriteEntity(
        id: id,
        mainImage: mainImage,
        name: name,
        details: details,
        price: price);

    await insertFavoriteUseCase.call(favoriteEntity);
  }

  void deleteFavorite(int id) async {
    await deleteFavoriteUseCase.call(id);
  }
}
