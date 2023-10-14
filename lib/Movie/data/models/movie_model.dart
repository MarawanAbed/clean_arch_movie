import 'package:movie_app/Movie/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.title,
    required super.image,
    required super.id,
    required super.overview,
    required super.releaseDate,
    required super.voteAverage,
    required super.genreIds,
    required super.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        title: json["title"],
        image: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
        overview: json["overview"],
        voteAverage: json["vote_average"].toDouble(),
        releaseDate: json["release_date"],
        runtime: json["runtime"],
      );
}
