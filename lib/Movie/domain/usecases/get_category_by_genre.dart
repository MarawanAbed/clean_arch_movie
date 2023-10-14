import 'package:dartz/dartz.dart';
import 'package:movie_app/Movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';

class GetMoviesByGenreUseCase extends UseCase<dynamic,int>{
  final MovieRepo _repo;

  GetMoviesByGenreUseCase(this._repo);
  @override
  Future<Either<Failure, dynamic>> call([int? parameter])async {
    return await _repo.fetchMoviesByGenre(parameter!);
  }
}