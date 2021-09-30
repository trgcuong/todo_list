import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {}

class NetworkException extends AppException {
  final String message;

  final int statusCode;

  NetworkException({this.message = "", this.statusCode = 0});
  @override
  String toString() => message;

  @override
  List<Object?> get props => [statusCode, message];
}

class DatabaseException extends AppException {
  final String? message;

  DatabaseException({this.message});
  @override
  String toString() => message ?? runtimeType.toString();

  @override
  List<Object?> get props => [message];
}
