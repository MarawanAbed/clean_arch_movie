import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String image;
  final int id;
  final String overview;
  final String releaseDate;
  final int? runtime;
  final double voteAverage;
  final List<int> genreIds;


  const Movie({
    this.runtime,
    required this.title,
    required this.image,
    required this.id,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
  });

  @override
  List<Object?> get props => [
        runtime,
        title,
        image,
        id,
        overview,
        releaseDate,
        voteAverage,
        genreIds,
      ];
}
