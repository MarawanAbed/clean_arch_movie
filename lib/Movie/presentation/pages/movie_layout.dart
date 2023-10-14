import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/Movie/presentation/pages/category.dart';
import 'package:movie_app/Movie/presentation/pages/favorite.dart';
import 'package:movie_app/Movie/presentation/pages/home.dart';
import 'package:movie_app/core/utils/app_string.dart';

class MovieLayout extends StatefulWidget {
  const MovieLayout({super.key});

  @override
  State<MovieLayout> createState() => _MovieLayoutState();
}

class _MovieLayoutState extends State<MovieLayout> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppString.homeBottomNavTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: AppString.categoryBottomNavTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppString.favoriteBottomNavTitle,
          ),
        ],
      ),
    );
  }
}
