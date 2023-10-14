import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/presentation/manager/movie/movie_cubit.dart';
import 'package:movie_app/Movie/presentation/pages/home_details.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/utils/app_string.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        final searchResults = cubit.searchMovies;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            title: const Text(AppString.searchTitle),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    cubit.searchMovie(value);
                  },
                  decoration: InputDecoration(
                    hintText: AppString.hintSearch,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: _buildSearchResults(searchResults),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(List<Movie> searchResults) {
    if (searchResults.isEmpty) {
      return const Center(
          child: Text(
        AppString.noResultsFound,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ));
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        final movie = searchResults[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              final movieCubit = MovieCubit.get(context);
              movieCubit.getMovieDetails(movie.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeDetails(id: movie.id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                ApiConstance.imageUrl(movie.image),
                fit: BoxFit.fill,
                width: 200.w,
                height: 250.h,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 2.0,
        );
      },
      itemCount: searchResults.length,
    );
  }
}
