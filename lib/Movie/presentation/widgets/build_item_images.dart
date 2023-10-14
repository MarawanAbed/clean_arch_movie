import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/presentation/widgets/image_item.dart';

class BuildItemImages extends StatelessWidget {
  const BuildItemImages({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ItemsImages(
            movie: movies[index],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
