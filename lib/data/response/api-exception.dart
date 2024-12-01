class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message])
      : super(message, 'Please turn on your internet');
}

class TimeOutException extends AppExceptions {
  TimeOutException([String? message])
      : super(message, 'Time run out , please try after some time ');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message])
      : super(message, 'Something went wrong');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, '');
}
