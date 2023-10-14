import 'package:movie_app/Movie/domain/entities/movie_category.dart';

class MoviesCategoryModel extends MovieCategory{
   MoviesCategoryModel({
    required super.name,
    required super.id,
  });

  factory MoviesCategoryModel.fromJson(Map<String, dynamic> json) => MoviesCategoryModel(
    id: json["id"],
    name: json["name"],
  );
}