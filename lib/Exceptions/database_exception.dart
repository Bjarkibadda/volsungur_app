class DatabaseError implements Exception{
  final String errorMessage;

  DatabaseError(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}