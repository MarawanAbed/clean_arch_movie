import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/Movie/data/source/remote_data_source/remote_data_source.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/domain/entities/movie_category.dart';
import 'package:movie_app/Movie/domain/entities/movie_details.dart';
import 'package:movie_app/Movie/domain/entities/recommendation.dart';
import 'package:movie_app/Movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/error/failure.dart';

class MovieRepoImpl implements MovieRepo {
  final RemoteDataSource _remoteDataSource;

  MovieRepoImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<MovieCategory>>> getCategoryMovies() async {
    try {
      final movie = await _remoteDataSource.getCategoryMovies();
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final movie = await _remoteDataSource.getPopularMovies();
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure,MovieDetail>> getMovieDetail(int movieId) async {
    try {
      final movie = await _remoteDataSource.getMovieDetail(movieId);
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getMovieRecommendations(
      int movieId) async {
    try {
      final movie = await _remoteDataSource.getMovieRecommendations(movieId);
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final movie = await _remoteDataSource.getTopRatedMovies();
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }



  @override
  Future<Either<Failure, List<Movie>>> searchMovie(String query) async {
    try {
      final movie = await _remoteDataSource.searchMovie(query);
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpComingMovies()async {
    try {
      final movie = await _remoteDataSource.getUpComingMovies();
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> fetchMoviesByGenre(int genreId)async{
    try {
      final movie = await _remoteDataSource.fetchMoviesByGenre(genreId);
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
