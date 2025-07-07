import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.properties = const <dynamic>[]]);

  final List<dynamic> properties;

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {
  const ServerFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class ObjectBoxFailure extends Failure {
  const ObjectBoxFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  const UnknownFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}