
import 'package:drift/drift.dart';
import 'package:store_app/data/local/data_bases/shop_db.dart';
import 'package:store_app/data/local/models/favorite_model.dart';

import '../../../domain/entities/favorite_entity.dart';
import 'favorites_data_source.dart';

part 'favorite_dao.g.dart';

@DriftAccessor(tables: [Favorite])
class FavoriteDao extends DatabaseAccessor<ShopDb> with _$FavoriteDaoMixin, FavoritesDataSource{

  FavoriteDao(ShopDb db) : super(db);

  @override
  Future<List<FavoriteEntity>> getFavorites() async{
    final favoriteDataList = await select(favorite).get();
    final List<FavoriteEntity> favoriteEntityList = [];
    for(final favoriteData in favoriteDataList){
      favoriteEntityList.add(FavoriteEntity.fromFavoriteData(favoriteData: favoriteData));
    }
    return favoriteEntityList;
  }

  @override
  Future<int> insertFavorite(FavoriteEntity favoriteEntity) async {

    final favoriteCompanion = FavoriteCompanion(
        id: Value(favoriteEntity.id),
        mainImage: Value(favoriteEntity.mainImage),
        name: Value(favoriteEntity.name),
        details: Value(favoriteEntity.details),
        price: Value(favoriteEntity.price)
    );

    return await into(favorite).insert(favoriteCompanion);
  }

  @override
  Future<int> deleteFavorite(int id) async {
    return await (delete(favorite)..where((tbl) => tbl.id.equals(id))).go();
  }

}