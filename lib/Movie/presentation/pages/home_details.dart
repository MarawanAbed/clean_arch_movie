import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Movie/domain/entities/genre.dart';
import 'package:movie_app/Movie/domain/entities/movie_details.dart';
import 'package:movie_app/Movie/presentation/manager/movie/movie_cubit.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({super.key, required this.id});

  final int id;

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  bool isFavorite = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _loadData();
  }

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs!.getBool(widget.id.toString()) ?? false;
    });
  }

  void _loadData() {
    final cubit = MovieCubit.get(context);
    cubit.getMovieDetails(widget.id);
    cubit.getMovieRecommendations(widget.id);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _showGenres(List<Genres> genres) {
    return genres.map((genre) => genre.name).join(', ');
  }

  Widget _showRecommendation() {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        final cubit = MovieCubit.get(context);
        final recommendations = cubit.moviesRecommendations;
        return SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index >= recommendations.length) {
                return null;
              }
              final movie = recommendations[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
                  child: CachedNetworkImage(
                    imageUrl: ApiConstance.imageUrl(movie.backdropPath!),
                    width: 200.w,
                    height: 250.h,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: MediaQuery.of(context).size.width * 0.03);
            },
            itemCount: recommendations.length,
          ),
        );
      },
    );
  }

  _toggleFavorite() {
    var cubit = MovieCubit.get(context);
    var details = cubit.moviesDetails;
    setState(() {
      isFavorite = !isFavorite;
      prefs!.setBool(widget.id.toString(), isFavorite);
    });

    final movieDetails = MovieDetail(
      backdropPath: details!.backdropPath,
      genres: details.genres,
      id: details.id,
      overview: details.overview,
      releaseDate: details.releaseDate,
      runtime: details.runtime,
      title: details.title,
      voteAverage: details.voteAverage,
    );

    if (isFavorite) {
      cubit.favoriteItems.add(movieDetails);
    } else {
      cubit.favoriteItems.remove(movieDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final cubit = MovieCubit.get(context);
        final details = cubit.moviesDetails;
        if (details == null) {
          return const SizedBox(); // Handle this case as needed
        }

        return Scaffold(
          body: WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
              return Future.value(false);
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.grey.shade900,
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: Stack(
                    children: [
                      FlexibleSpaceBar(
                        background: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: ApiConstance.imageUrl(details.backdropPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                            size: 32.0,
                          ),
                          onPressed: () {
                            _toggleFavorite();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              details.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0.sp,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      details.releaseDate.split('-')[0],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Text(
                                      details.voteAverage.toStringAsFixed(1),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  _showDuration(details.runtime),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              details.overview,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              '${AppString.genreTitle}: ${_showGenres(details.genres)}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Text(
                              AppString.moreLikeTitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            _showRecommendation(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
