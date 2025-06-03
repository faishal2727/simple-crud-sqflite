// ignore_for_file: use_super_parameters

abstract class Failure {
  final String message;

  Failure(this.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(String message) : super(message);
}
