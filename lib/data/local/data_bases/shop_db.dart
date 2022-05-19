
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:store_app/data/local/models/cached_products_model.dart';
import 'package:store_app/data/local/models/favorite_model.dart';
import 'package:store_app/domain/entities/favorite_entity.dart';
part 'shop_db.g.dart';

LazyDatabase _openConnection(){
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'shopdb.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Favorite, CachedProducts])
class ShopDb extends _$ShopDb {
  ShopDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}