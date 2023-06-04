class HttpExeception implements Exception {
  String message;
  HttpExeception(this.message);

  @override
  String toString() {
    return message;
  }
}
