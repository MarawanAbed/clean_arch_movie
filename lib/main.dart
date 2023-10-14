import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Movie/domain/usecases/get_category_by_genre.dart';
import 'package:movie_app/Movie/domain/usecases/get_category_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_movie_details.dart';
import 'package:movie_app/Movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie_app/Movie/domain/usecases/get_popular_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app/Movie/domain/usecases/get_up_coming_movies.dart';
import 'package:movie_app/Movie/domain/usecases/search_movie.dart';
import 'package:movie_app/Movie/presentation/manager/movie/movie_cubit.dart';
import 'package:movie_app/Movie/presentation/pages/movie_layout.dart';
import 'package:movie_app/core/services/bloc_observer.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/utils/app_string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MovieCubit(
              moviesByGenre: sl<GetMoviesByGenreUseCase>(),
              upComing: sl<GetUpComingMoviesUseCase>(),
              topRated: sl<GetTopRatedMoviesUseCase>(),
              latest: sl<GetPopularMoviesUseCase>(),
              category: sl<GetCategoryMoviesUseCase>(),
              recommendations: sl<GetRecommendationsMoviesUseCase>(),
              search: sl<SearchMoviesUseCase>(),
              details: sl<GetMoviesDetailsUseCase>(),
            )
              ..getUpComingMovies()
              ..getTopRatedMovies()
              ..getLatestMovies()
              ..getCategoryMovies(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppString.title,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade900,
          ),
          home: const MovieLayout(),
        ),
      ),
    );
  }
}
