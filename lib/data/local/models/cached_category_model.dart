import 'package:drift/drift.dart';

class CachedCategory extends Table {
  TextColumn get name => text().named('category_name')();
  TextColumn get icon => text().named('category_icon')();

  @override
  Set<Column> get primaryKey => {name};
}