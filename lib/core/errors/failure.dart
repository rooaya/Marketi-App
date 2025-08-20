import 'package:marketiapp/core/errors/error_model.dart';


abstract class Failure {
  final ErrorModel errorModel;
  const Failure(this.errorModel);

}

// Corresponding to exceptions
class ServerFailure extends Failure {
  ServerFailure(super.errorModel);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.errorModel);
}

class NotFoundFailure extends Failure {
  NotFoundFailure(super.errorModel);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.errorModel);
}
// failure.dart


