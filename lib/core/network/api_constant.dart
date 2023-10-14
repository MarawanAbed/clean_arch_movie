class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "e063096a1f50982bd1b734c83ccd0702";

  static const String upComingMoviesPath =
      "$baseUrl/movie/upcoming?api_key=$apiKey";
  static const String popularMoviesPath =
      "$baseUrl/movie/popular?api_key=$apiKey";
  static const String topRatedMoviesPath =
      "$baseUrl/movie/top_rated?api_key=$apiKey";

  static String movieDetailsPath(int movieId) =>
      "$baseUrl/movie/$movieId?api_key=$apiKey";

  static String searchMoviePath(String query) =>
      "$baseUrl/search/movie?api_key=$apiKey&query=$query";

  static String getCategoryMoviesPath() =>
      "$baseUrl/genre/movie/list?api_key=$apiKey";

  static String getMoviesGendrePath(int genreId) =>
      "$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId";
  static String recommendationPath(int movieId) =>
      "$baseUrl/movie/$movieId/recommendations?api_key=$apiKey";

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => '$baseImageUrl$path';
}
