import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  CategoryEntity({
    required this.name,
    required this.icon,
  });

  final String name;
  final String icon;

  @override
  // TODO: implement props
  List<Object?> get props => [name, icon];
}
