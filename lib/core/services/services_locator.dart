import 'package:get_it/get_it.dart';
import 'package:movie_app/Movie/data/repositories/movie_repo_impl.dart';
import 'package:movie_app/Movie/data/source/remote_data_source/remote_data_source.dart';
import 'package:movie_app/Movie/data/source/remote_data_source/remote_data_source_imp.dart';
import 'package:movie_app/Movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/Movie/domain/usecases/get_category_by_genre.dart';
import 'package:movie_app/Movie/domain/usecases/get_category_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_movie_details.dart';
import 'package:movie_app/Movie/domain/usecases/get_popular_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie_app/Movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_up_coming_movies.dart';
import 'package:movie_app/Movie/domain/usecases/search_movie.dart';

final sl=GetIt.instance;

class ServicesLocator {
  void init()
  {
    sl.registerLazySingleton(() => GetCategoryMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetRecommendationsMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetUpComingMoviesUseCase(sl()));
    sl.registerLazySingleton(() => SearchMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMoviesDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetMoviesByGenreUseCase(sl()));
    sl.registerLazySingleton<MovieRepo>(() => MovieRepoImpl(sl()));

    sl.registerLazySingleton<RemoteDataSource>(() => RemoteSourceDataSourceImpl());
  }
}