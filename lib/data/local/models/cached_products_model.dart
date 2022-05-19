
import 'package:drift/drift.dart';

class CachedProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mainImage => text().named('main_image_link')();
  TextColumn get name => text().named('product_name')();
  TextColumn get details => text().named('product_details')();
  RealColumn get price => real().named('product_price')();
}