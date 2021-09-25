import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter(), );

class AppLog {

 static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.v(message, error, stackTrace);
  }

 static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error, stackTrace);
  }

 static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error, stackTrace);
  }

 static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error, stackTrace);
  }
}
