abstract class AppException implements Exception {}

class NetworkException extends AppException {
  final String message;

  final int statusCode;

  NetworkException({this.message = "", this.statusCode = 0});
  @override
  String toString() => message;
}
