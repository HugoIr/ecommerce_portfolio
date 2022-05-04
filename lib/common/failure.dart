abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super("ServerFailure: " + message);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(String message) : super("ServerFailure: " + message);
}
