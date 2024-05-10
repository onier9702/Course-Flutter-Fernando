class WrongCredentials implements Exception {}
class InvalidToken implements Exception {}
class ConnectionTimeout implements Exception {}

class CustomError implements Exception {
  final String message;
  final int errorStatusCode;

  CustomError(
    this.message, 
    this.errorStatusCode
  );
}
