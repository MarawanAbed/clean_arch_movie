import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Movie/domain/entities/movie_details.dart';
import 'package:movie_app/Movie/presentation/manager/movie/movie_cubit.dart';
import 'package:movie_app/Movie/presentation/pages/home_details.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/utils/app_string.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = MovieCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        title: const Text(AppString.favoriteTitle),
      ),
      body: cubit.favoriteItems.isEmpty
          ? const Center(
              child: Text(
                AppString.noFavoriteTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              itemCount: cubit.favoriteItems.length,
              itemBuilder: (context, index) {
                final favoriteItem = cubit.favoriteItems[index];
                return buildFavoriteItem(favoriteItem);
              },
            ),
    );
  }

  Widget buildFavoriteItem(MovieDetail favoriteItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeDetails(
              id: favoriteItem.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                buildMovieImage(favoriteItem.backdropPath),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Expanded(
                  child: buildMovieDetails(favoriteItem),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMovieImage(String? backdropPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(
        image: NetworkImage(ApiConstance.imageUrl(backdropPath!)),
        height: 160.0.h,
        width: 120.0.w,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildMovieDetails(MovieDetail favoriteItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          favoriteItem.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        buildReleaseDateAndRating(favoriteItem),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Text(
          favoriteItem.overview,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget buildReleaseDateAndRating(MovieDetail favoriteItem) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              favoriteItem.releaseDate.split('-')[0],
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(
              (favoriteItem.voteAverage.toStringAsFixed(1)).toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
