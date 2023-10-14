import 'package:movie_app/Movie/data/models/category.dart';
import 'package:movie_app/Movie/data/models/movie_details.dart';
import 'package:movie_app/Movie/data/models/movie_model.dart';
import 'package:movie_app/Movie/data/models/recommendation.dart';


abstract class RemoteDataSource
{

  Future<List<MovieModel>> searchMovie(String query);
  Future<List<MovieModel>>getUpComingMovies();
  Future<List<MovieModel>>getPopularMovies();
  Future<List<MovieModel>>getTopRatedMovies();
  Future<List<MoviesCategoryModel>>getCategoryMovies();
  Future<MovieDetailsModel> getMovieDetail(int movieId);
  Future<List<RecommendationModel>>getMovieRecommendations(int movieId);
  Future<List<MovieModel>> fetchMoviesByGenre(int genreId);
}