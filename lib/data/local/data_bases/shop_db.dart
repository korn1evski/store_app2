
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:store_app/data/local/models/favorite_model.dart';
import 'package:store_app/domain/entities/favorite_entity.dart';
part 'shop_db.g.dart';

LazyDatabase _openConnection(){
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'shop.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Favorite])
class ShopDb extends _$ShopDb {
  ShopDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //Get list of favorites

  Future<List<FavoriteEntity>> getFavorites() async{
    final favoriteDataList = await select(favorite).get();
    final List<FavoriteEntity> favoriteEntityList = [];
    for(final favoriteData in favoriteDataList){
      favoriteEntityList.add(FavoriteEntity.fromFavoriteData(favoriteData: favoriteData));
    }
    return favoriteEntityList;
  }

  Future<FavoriteEntity?> getFavorite(int id) async{
    try{
      final favoriteData = await (select(favorite)..where((tbl) => tbl.id.equals(id))).getSingle();
      return FavoriteEntity.fromFavoriteData(favoriteData: favoriteData);
    } catch (e){
      return null;
    }
  }

  Future<bool> updateFavorite(FavoriteCompanion favoriteCompanion) async{
    return await update(favorite).replace(favoriteCompanion);
  }

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

  Future<int> deleteFavorite(int id) async {
    return await (delete(favorite)..where((tbl) => tbl.id.equals(id))).go();
  }

}