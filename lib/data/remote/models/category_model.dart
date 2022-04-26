import 'package:store_app/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity{
  CategoryModel({
    required this.name,
    required this.icon,
  }) : super(name: name, icon: icon);

  String name;
  String icon;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
  };

  static List<CategoryEntity> categoryModelsToEntity(List<CategoryModel> listModels){
    List<CategoryEntity> listEntities = [];
    for (var model in listModels){
      var entity = CategoryEntity(name: model.name, icon: model.icon);
      listEntities.add(entity);
    }

    return listEntities;
  }
  static CategoryEntity categoryModelToEntity(CategoryModel model){
    var entity = CategoryEntity(name: model.name, icon: model.icon);
    return entity;
  }
}

