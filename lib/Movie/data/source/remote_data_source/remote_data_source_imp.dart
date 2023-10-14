import 'package:dio/dio.dart';
import 'package:movie_app/Movie/data/models/category.dart';
import 'package:movie_app/Movie/data/models/movie_details.dart';
import 'package:movie_app/Movie/data/models/movie_model.dart';
import 'package:movie_app/Movie/data/models/recommendation.dart';
import 'package:movie_app/Movie/data/source/remote_data_source/remote_data_source.dart';
import 'package:movie_app/core/network/api_constant.dart';

class RemoteSourceDataSourceImpl implements RemoteDataSource {
  @override
  Future<List<MoviesCategoryModel>> getCategoryMovies() async {
    final response = await Dio().get(ApiConstance.getCategoryMoviesPath());
    if (response.statusCode == 200) {
      final List<dynamic> genreList = response.data['genres'];
      final categories = genreList.map((genreJson) {
        return MoviesCategoryModel.fromJson(genreJson);
      }).toList();
      return categories;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await Dio().get(ApiConstance.popularMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetail(int movieId) async {
    final response = await Dio().get(ApiConstance.movieDetailsPath(movieId));
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<RecommendationModel>> getMovieRecommendations(int movieId) async {
    final response = await Dio().get(ApiConstance.recommendationPath(movieId));
    if (response.statusCode == 200) {
      return List<RecommendationModel>.from((response.data["results"] as List)
          .map((e) => RecommendationModel.fromJson(e)));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await Dio().get(ApiConstance.topRatedMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieModel>> getUpComingMovies() async {
    final response = await Dio().get(ApiConstance.upComingMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieModel>> searchMovie(String query) async {
    final response = await Dio().get(ApiConstance.searchMoviePath(query));
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieModel>> fetchMoviesByGenre(int genreId) async{
    final response = await Dio().get(ApiConstance.getMoviesGendrePath(genreId));
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
