import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/presentation/manager/movie/movie_cubit.dart';
import 'package:movie_app/Movie/presentation/pages/search.dart';
import 'package:movie_app/Movie/presentation/pages/see_details_popular.dart';
import 'package:movie_app/Movie/presentation/pages/see_details_top.dart';
import 'package:movie_app/Movie/presentation/pages/see_details_upcoming.dart';
import 'package:movie_app/Movie/presentation/widgets/build_item_images.dart';
import 'package:movie_app/core/utils/app_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  Widget _textButton(Widget screen) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      child: Text(
        AppString.seeAllTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 14.0.sp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        final cubit = MovieCubit.get(context);
        if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black26,
              elevation: 0.0,
              title: const Text(AppString.homeTitle),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ));
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: AppString.upComingTitle,
                      movies: cubit.upComingMovies,
                      seeAllScreen: SeeAllDetailsUpComing(
                        movies: cubit.upComingMovies,
                      ),
                    ),
                    _buildSection(
                      title: AppString.popularTitle,
                      movies: cubit.popularMovies,
                      seeAllScreen: SeeAllDetailsPopular(
                        movies: cubit.popularMovies,
                      ),
                    ),
                    _buildSection(
                      title: AppString.topRatedTitle,
                      movies: cubit.topRatedMovies,
                      seeAllScreen: SeeAllDetailsTop(
                        movies: cubit.topRatedMovies,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildSection({
    required String title,
    required List<Movie> movies,
    required Widget seeAllScreen,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0.sp,
              ),
            ),
            _textButton(seeAllScreen),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        BuildItemImages(movies: movies),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }
}
