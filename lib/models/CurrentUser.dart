
class CurrentUser {
  static final CurrentUser _singleton = CurrentUser._internal();
  static String uid;

  factory CurrentUser() => _singleton;

  CurrentUser._internal(); // private constructor
}
