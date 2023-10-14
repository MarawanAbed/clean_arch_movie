import 'package:dartz/dartz.dart';
import 'package:movie_app/Movie/domain/entities/movie.dart';
import 'package:movie_app/Movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';

class GetPopularMoviesUseCase extends UseCase<List<Movie>,NoParameter> {
  final MovieRepo _repo;

  GetPopularMoviesUseCase(this._repo);

  @override
  Future<Either<Failure, List<Movie>>> call([NoParameter? parameter]) async {
    return await _repo.getPopularMovies();
  }
}