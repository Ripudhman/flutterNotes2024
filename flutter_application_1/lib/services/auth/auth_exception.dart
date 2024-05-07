//login exception handling
class UserNotFoundAuthException implements Exception {}

class WrongPassworAuthException implements Exception {}

//register exception hadling

class WeakPasswordAuthException implements Exception {}

class EmailAlredyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//generic exception

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
