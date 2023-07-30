class Failure {
  final String message;

  Failure(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Failure && runtimeType == other.runtimeType && message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}
