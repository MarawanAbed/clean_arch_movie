import 'package:dartz/dartz.dart';
import 'package:movie_app/Movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';

class GetUpComingMoviesUseCase extends UseCase<dynamic,NoParameter> {
  final MovieRepo _repo;

  GetUpComingMoviesUseCase(this._repo);

  @override
  Future<Either<Failure, dynamic>> call([NoParameter? parameter]) async {
    return await _repo.getUpComingMovies();
  }
}