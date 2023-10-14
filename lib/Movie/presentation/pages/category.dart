import 'package:flutter/material.dart';
import 'package:movie_app/Movie/presentation/manager/movie/movie_cubit.dart';
import 'package:movie_app/Movie/presentation/widgets/build_category_item.dart';
import 'package:movie_app/core/utils/app_string.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = MovieCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Text(
                AppString.categoryTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final category = cubit.categoryMovies[index];

                  return ListTile(
                    title: Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuildCategoryItems(
                            id: category.id,
                            name: category.name,
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  );
                },
                itemCount: cubit.categoryMovies.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
