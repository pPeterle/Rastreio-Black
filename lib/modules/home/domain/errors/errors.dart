abstract class Failure implements Exception {}

class InvalidTextError extends Failure {}

class CodeNotFoundError extends Failure {}

class DataSourceError extends Failure {}

class EditDefaultListError extends Failure {}
