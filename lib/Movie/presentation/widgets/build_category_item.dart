import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Movie/presentation/manager/movie/movie_cubit.dart';
import 'package:movie_app/Movie/presentation/pages/home_details.dart';
import 'package:movie_app/core/network/api_constant.dart';

class BuildCategoryItems extends StatefulWidget {
  final int id;
  final String name;

  const BuildCategoryItems({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<BuildCategoryItems> createState() => _BuildCategoryItemsState();
}

class _BuildCategoryItemsState extends State<BuildCategoryItems> {
  @override
  void initState() {
    super.initState();
    MovieCubit.get(context).getCategoryByGenre(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        final cubit = MovieCubit.get(context);

        if (state is MovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            title: Text(widget.name),
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    cubit.getMovieDetails(cubit.categorizedMovies[index].id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeDetails(
                          id: cubit.categorizedMovies[index].id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          ApiConstance.imageUrl(
                              cubit.categorizedMovies[index].image),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: cubit.categorizedMovies.length,
          ),
        );
      },
    );
  }
}
