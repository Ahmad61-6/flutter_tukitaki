class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}
class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'A cache error occurred']);

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'No internet connection']);

  @override
  String toString() => 'NetworkException: $message';
}
