part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object> get props => [];
}

class UpComingMovieLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class TopRatedMovieLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class PopularMovieLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class CategoryMovieLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieRecommendationsLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieSearchLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class CategoryByGenreLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class SearchMovieLoaded extends MovieState {
  @override
  List<Object> get props => [];
}
class MovieDetailsLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class RecommendationMovieLoaded extends MovieState {
  @override
  List<Object> get props => [];
}

class UpComingMovieError extends MovieState {
  final String message;

  const UpComingMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMovieError extends MovieState {
  final String message;

  const TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMovieError extends MovieState {
  final String message;

  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailsError extends MovieState {
  final String message;

  const MovieDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationMovieError extends MovieState {
  final String message;

  const RecommendationMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryMovieError extends MovieState {
  final String message;

  const CategoryMovieError(this.message);

  @override
  List<Object> get props => [message];
}
class CategoryByGenreMovieError extends MovieState {
  final String message;

  const CategoryByGenreMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMovieError extends MovieState {
  final String message;

  const SearchMovieError(this.message);

  @override
  List<Object> get props => [message];
}