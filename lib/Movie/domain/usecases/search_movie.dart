import 'package:dartz/dartz.dart';
import 'package:movie_app/Movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';

class SearchMoviesUseCase extends UseCase<dynamic,String>{
  final MovieRepo _repo;

  SearchMoviesUseCase(this._repo);
  @override
  Future<Either<Failure, dynamic>> call([String? parameter])async {
    return await _repo.searchMovie(parameter!);
  }
}