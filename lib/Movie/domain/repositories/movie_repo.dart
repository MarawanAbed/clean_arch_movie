import 'package:dartz/dartz.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/domain/entities/movie_category.dart';
import 'package:movie_app/Movie/domain/entities/movie_details.dart';
import 'package:movie_app/Movie/domain/entities/recommendation.dart';
import 'package:movie_app/core/error/failure.dart';

abstract class MovieRepo{

  Future<Either<Failure, List<Movie>>> searchMovie(String query);
  Future<Either<Failure, List<Movie>>>getUpComingMovies();
  Future<Either<Failure, List<Movie>>>getPopularMovies();
  Future<Either<Failure, List<Movie>>>getTopRatedMovies();
  Future<Either<Failure, List<MovieCategory>>>getCategoryMovies();
  Future<Either<Failure, MovieDetail>>getMovieDetail(int movieId);
  Future<Either<Failure, List<Recommendation>>>getMovieRecommendations(int movieId);
  Future<Either<Failure,List<Movie>>> fetchMoviesByGenre(int genreId);
}