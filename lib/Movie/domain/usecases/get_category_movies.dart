import 'package:dartz/dartz.dart';
import 'package:movie_app/Movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';

class GetCategoryMoviesUseCase extends UseCase<dynamic,NoParameter>{
  final MovieRepo _repo;

  GetCategoryMoviesUseCase(this._repo);
  @override
  Future<Either<Failure, dynamic>> call([NoParameter? parameter])async {
    return await _repo.getCategoryMovies();
  }
}