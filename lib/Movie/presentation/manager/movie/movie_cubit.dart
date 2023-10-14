import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/domain/entities/movie_category.dart';
import 'package:movie_app/Movie/domain/entities/movie_details.dart';
import 'package:movie_app/Movie/domain/entities/recommendation.dart';
import 'package:movie_app/Movie/domain/usecases/get_category_by_genre.dart';
import 'package:movie_app/Movie/domain/usecases/get_category_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_movie_details.dart';
import 'package:movie_app/Movie/domain/usecases/get_popular_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_up_coming_movies.dart';
import 'package:movie_app/Movie/domain/usecases/search_movie.dart';

import '../../../domain/usecases/get_movie_recommendations.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({
    required this.details,
    required this.upComing,
    required this.topRated,
    required this.latest,
    required this.moviesByGenre,
    required this.category,
    required this.recommendations,
    required this.search,
  }) : super(MovieInitial());

  final GetUpComingMoviesUseCase upComing;
  final GetTopRatedMoviesUseCase topRated;
  final GetPopularMoviesUseCase latest;
  final GetCategoryMoviesUseCase category;
  final GetRecommendationsMoviesUseCase recommendations;
  final SearchMoviesUseCase search;
  final GetMoviesDetailsUseCase details;
  final GetMoviesByGenreUseCase moviesByGenre;

  static MovieCubit get(context) => BlocProvider.of(context);

  List<Movie> upComingMovies = [];
  final List<MovieDetail> favoriteItems = [];

  getUpComingMovies() async {
    emit(MovieLoading());
    final result = await upComing.call();
    result.fold((failure) => emit(UpComingMovieError(failure.message)),
        (movies) {
      upComingMovies = movies;
      emit(UpComingMovieLoaded());
    });
  }

  List<Movie> topRatedMovies = [];

  getTopRatedMovies() async {
    emit(MovieLoading());
    final result = await topRated.call();
    result.fold((failure) => emit(TopRatedMovieError(failure.message)),
        (movies) {
      topRatedMovies = movies;
      emit(TopRatedMovieLoaded());
    });
  }

  List<Movie> popularMovies = [];

  getLatestMovies() async {
    emit(MovieLoading());
    final result = await latest.call();
    result.fold(
      (failure) => emit(PopularMovieError(failure.message)),
      (movies) {
        popularMovies = movies;
        emit(PopularMovieLoaded());
      },
    );
  }

  MovieDetail? moviesDetails;

  getMovieDetails(int movieId) async {
    emit(MovieLoading());
    final result = await details.call(movieId);
    result.fold(
      (failure) => emit(MovieDetailsError(failure.message)),
      (movie) {
        moviesDetails = movie;
        emit(MovieDetailsLoaded());
      },
    );
  }

  List<Recommendation> moviesRecommendations = [];

  getMovieRecommendations(int movieId) async {
    emit(MovieLoading());
    final result = await recommendations.call(movieId);
    result.fold(
      (failure) => emit(RecommendationMovieError(failure.message)),
      (movies) {
        moviesRecommendations = movies;
        emit(RecommendationMovieLoaded());
      },
    );
  }

  List<MovieCategory> categoryMovies = [];

  getCategoryMovies() async {
    emit(MovieLoading());
    final result = await category.call();
    result.fold(
      (failure) => emit(CategoryMovieError(failure.message)),
      (movies) {
        categoryMovies = movies;
        emit(CategoryMovieLoaded());
      },
    );
  }

  List<Movie> categorizedMovies = [];

  getCategoryByGenre(int genreId) async {
    emit(MovieLoading());
    final result = await moviesByGenre.call(genreId);
    result.fold(
      (failure) => emit(CategoryByGenreMovieError(failure.message)),
      (movies) {
        categorizedMovies = movies;
        emit(CategoryByGenreLoaded());
      },
    );
  }

  List<Movie> searchMovies = [];

  searchMovie(String query) async {
    final result = await search.call(query);
    result.fold(
      (failure) => emit(SearchMovieError(failure.message)),
      (movies) {
        searchMovies = movies;
        emit(SearchMovieLoaded());
      },
    );
  }
}
