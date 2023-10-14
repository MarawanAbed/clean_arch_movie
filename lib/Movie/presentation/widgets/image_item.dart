import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/presentation/manager/movie/movie_cubit.dart';
import 'package:movie_app/Movie/presentation/pages/home_details.dart';
import 'package:movie_app/core/network/api_constant.dart';

class ItemsImages extends StatelessWidget {
  const ItemsImages({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MovieCubit.get(context).getMovieDetails(movie.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeDetails(
              id: movie.id,
            ),
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
    );
  }
}
