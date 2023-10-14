import 'package:flutter/material.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/presentation/widgets/build_see_all.dart';
import 'package:movie_app/core/utils/app_string.dart';

class SeeAllDetailsTop extends StatelessWidget {
  const SeeAllDetailsTop({super.key, required this.movies});
  final List<Movie>movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text(AppString.topRatedTitle),
      ),
      body: BuildSeeAll(movies: movies),
    );
  }
}
