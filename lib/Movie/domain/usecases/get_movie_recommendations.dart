import 'package:dartz/dartz.dart';
import 'package:movie_app/Movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';

class GetRecommendationsMoviesUseCase extends UseCase<dynamic,int>{
  final MovieRepo _repo;

  GetRecommendationsMoviesUseCase(this._repo);
  @override
  Future<Either<Failure, dynamic>> call([int? parameter])async {
    return await _repo.getMovieRecommendations(parameter!);
  }
}