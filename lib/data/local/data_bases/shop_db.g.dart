// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final int id;
  final String mainImage;
  final String name;
  final String details;
  final double price;
  FavoriteData(
      {required this.id,
      required this.mainImage,
      required this.name,
      required this.details,
      required this.price});
  factory FavoriteData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      mainImage: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}main_image_link'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name'])!,
      details: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_details'])!,
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_price'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['main_image_link'] = Variable<String>(mainImage);
    map['product_name'] = Variable<String>(name);
    map['product_details'] = Variable<String>(details);
    map['product_price'] = Variable<double>(price);
    return map;
  }

  FavoriteCompanion toCompanion(bool nullToAbsent) {
    return FavoriteCompanion(
      id: Value(id),
      mainImage: Value(mainImage),
      name: Value(name),
      details: Value(details),
      price: Value(price),
    );
  }

  factory FavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteData(
      id: serializer.fromJson<int>(json['id']),
      mainImage: serializer.fromJson<String>(json['mainImage']),
      name: serializer.fromJson<String>(json['name']),
      details: serializer.fromJson<String>(json['details']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mainImage': serializer.toJson<String>(mainImage),
      'name': serializer.toJson<String>(name),
      'details': serializer.toJson<String>(details),
      'price': serializer.toJson<double>(price),
    };
  }

  FavoriteData copyWith(
          {int? id,
          String? mainImage,
          String? name,
          String? details,
          double? price}) =>
      FavoriteData(
        id: id ?? this.id,
        mainImage: mainImage ?? this.mainImage,
        name: name ?? this.name,
        details: details ?? this.details,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteData(')
          ..write('id: $id, ')
          ..write('mainImage: $mainImage, ')
          ..write('name: $name, ')
          ..write('details: $details, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mainImage, name, details, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteData &&
          other.id == this.id &&
          other.mainImage == this.mainImage &&
          other.name == this.name &&
          other.details == this.details &&
          other.price == this.price);
}

class FavoriteCompanion extends UpdateCompanion<FavoriteData> {
  final Value<int> id;
  final Value<String> mainImage;
  final Value<String> name;
  final Value<String> details;
  final Value<double> price;
  const FavoriteCompanion({
    this.id = const Value.absent(),
    this.mainImage = const Value.absent(),
    this.name = const Value.absent(),
    this.details = const Value.absent(),
    this.price = const Value.absent(),
  });
  FavoriteCompanion.insert({
    this.id = const Value.absent(),
    required String mainImage,
    required String name,
    required String details,
    required double price,
  })  : mainImage = Value(mainImage),
        name = Value(name),
        details = Value(details),
        price = Value(price);
  static Insertable<FavoriteData> custom({
    Expression<int>? id,
    Expression<String>? mainImage,
    Expression<String>? name,
    Expression<String>? details,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mainImage != null) 'main_image_link': mainImage,
      if (name != null) 'product_name': name,
      if (details != null) 'product_details': details,
      if (price != null) 'product_price': price,
    });
  }

  FavoriteCompanion copyWith(
      {Value<int>? id,
      Value<String>? mainImage,
      Value<String>? name,
      Value<String>? details,
      Value<double>? price}) {
    return FavoriteCompanion(
      id: id ?? this.id,
      mainImage: mainImage ?? this.mainImage,
      name: name ?? this.name,
      details: details ?? this.details,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mainImage.present) {
      map['main_image_link'] = Variable<String>(mainImage.value);
    }
    if (name.present) {
      map['product_name'] = Variable<String>(name.value);
    }
    if (details.present) {
      map['product_details'] = Variable<String>(details.value);
    }
    if (price.present) {
      map['product_price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCompanion(')
          ..write('id: $id, ')
          ..write('mainImage: $mainImage, ')
          ..write('name: $name, ')
          ..write('details: $details, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $FavoriteTable extends Favorite
    with TableInfo<$FavoriteTable, FavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _mainImageMeta = const VerificationMeta('mainImage');
  @override
  late final GeneratedColumn<String?> mainImage = GeneratedColumn<String?>(
      'main_image_link', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'product_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _detailsMeta = const VerificationMeta('details');
  @override
  late final GeneratedColumn<String?> details = GeneratedColumn<String?>(
      'product_details', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double?> price = GeneratedColumn<double?>(
      'product_price', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, mainImage, name, details, price];
  @override
  String get aliasedName => _alias ?? 'favorite';
  @override
  String get actualTableName => 'favorite';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('main_image_link')) {
      context.handle(
          _mainImageMeta,
          mainImage.isAcceptableOrUnknown(
              data['main_image_link']!, _mainImageMeta));
    } else if (isInserting) {
      context.missing(_mainImageMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(_nameMeta,
          name.isAcceptableOrUnknown(data['product_name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('product_details')) {
      context.handle(
          _detailsMeta,
          details.isAcceptableOrUnknown(
              data['product_details']!, _detailsMeta));
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    if (data.containsKey('product_price')) {
      context.handle(_priceMeta,
          price.isAcceptableOrUnknown(data['product_price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoriteData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoriteTable createAlias(String alias) {
    return $FavoriteTable(attachedDatabase, alias);
  }
}

abstract class _$ShopDb extends GeneratedDatabase {
  _$ShopDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $FavoriteTable favorite = $FavoriteTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favorite];
}
