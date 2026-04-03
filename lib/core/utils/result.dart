import "package:calling_app/core/errors/failure.dart";
import "package:dartz/dartz.dart";

typedef Result<T> = Either<Failure, T>;
typedef FutureResult<T> = Future<Either<Failure, T>>;
