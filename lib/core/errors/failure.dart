import 'package:codebase_project_assignment/core/errors/bar_request_model.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  final String? message;
  final int? statusCode;
  final Map<String, String>? headers;
  final BadRequestData? badRequestData;

  const ServerFailure(
      {this.message, this.statusCode, this.headers, this.badRequestData});

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidInputFailure extends Failure {
  String? message;
  InvalidInputFailure({this.message});
  @override
  List<Object?> get props => [];
}
