/// Helpers singleton class
class Helpers {
  /// Helpers singleton variable
  static final Helpers _helpers = Helpers._singletonConstructor();

  /// Singleton factory
  factory Helpers() {
    return _helpers;
  }

  /// Singleton constructor
  Helpers._singletonConstructor();

  String capitalize(String text) {
    if (text.isEmpty) {
      return '';
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
