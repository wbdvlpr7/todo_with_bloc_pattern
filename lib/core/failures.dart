import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({
    this.code,
    this.message,
  });
  final int? code;
  final String? message;
  @override
  List<Object?> get props => [code, message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.code, super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({super.code, super.message});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({
    super.code = 101,
    super.message = 'ارتباط با اینترنت برقرار نیست',
  });
}
